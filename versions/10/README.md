# @tsonic/dotnet

TypeScript type definitions for .NET 10 BCL (Base Class Library).

## Versioning

This repo is versioned by **.NET major**:

- **.NET 10** → `versions/10/` → npm: `@tsonic/dotnet@10.x`

When publishing, run: `npm publish versions/10 --access public`

## Features

- ✅ **Complete .NET 10 BCL coverage** - 130 namespaces, 4,296 types, 50,675 members
- ✅ **camelCase members** - TypeScript-friendly naming conventions
- ✅ **Friendly generic aliases** - Use `List<T>` instead of `List_1<T>`
- ✅ **Primitive aliases** - `int`, `long`, `decimal`, etc. via `@tsonic/core`
- ✅ **Full type safety** - Zero TypeScript errors

## Installation

```bash
npm install @tsonic/dotnet @tsonic/core
```

## Usage

### Collections

```typescript
import type { List, Dictionary, HashSet } from "@tsonic/dotnet/System.Collections.Generic.js";
import type { int, decimal } from "@tsonic/core/types.js";

const ages: List<int> = null!;
const prices: Dictionary<string, decimal> = null!;
const uniqueIds: HashSet<int> = null!;
```

### Async Programming

```typescript
import type { Task } from "@tsonic/dotnet/System.Threading.Tasks.js";
import type { int } from "@tsonic/core/types.js";

const asyncResult: Task<int> = null!;
```

### Core Types

```typescript
import type { Nullable, Action, Func } from "@tsonic/dotnet/System.js";
import type { int } from "@tsonic/core/types.js";

const optional: Nullable<int> = null!;
const callback: Action<int> = null!;
const converter: Func<int, string> = null!;
```

### LINQ

```typescript
import type { IEnumerable, IQueryable } from "@tsonic/dotnet/System.Linq.js";
import type { int } from "@tsonic/core/types.js";

const sequence: IEnumerable<int> = null!;
```

## Package Structure

- **130 namespaces** - All major .NET namespaces
- **Flat ESM modules** - Clean import paths
- **Metadata sidecars** - `metadata.json` files for CLR-specific info
- **Support types** - Unsafe markers (`ptr<T>`) and primitives imported from `@tsonic/core`

## Naming Conventions

- **Types**: PascalCase (matches .NET)
- **Members**: camelCase (TypeScript convention)
- **Generics**: Friendly aliases (`List<T>` vs `List_1<T>`)

## Examples

### File I/O

```typescript
import type { Stream, FileStream } from "@tsonic/dotnet/System.IO.js";
```

### Networking

```typescript
import type { HttpClient } from "@tsonic/dotnet/System.Net.Http.js";
import type { IPAddress, Socket } from "@tsonic/dotnet/System.Net.js";
```

### Serialization

```typescript
import type { JsonSerializer } from "@tsonic/dotnet/System.Text.Json.js";
```

## Development

### Regenerating Types

To regenerate TypeScript declarations from .NET assemblies:

```bash
./__build/scripts/generate.sh
```

**Prerequisites:**
- .NET 10 SDK installed
- `tsbindgen` repository cloned at `../tsbindgen` (sibling directory)

The script will:
1. Clean existing namespace directories
2. Build tsbindgen
3. Generate fresh TypeScript declarations

**Environment variables:**
- `DOTNET_VERSION` - .NET runtime version (default: `10.0.1`)
- `DOTNET_HOME` - .NET installation directory (default: `$HOME/.dotnet`)

### Package Structure

```
@tsonic/dotnet/
├── families.json                      # Multi-arity family index
├── __internal/extensions/index.d.ts   # Extension method buckets
├── System.d.ts                        # Facade (public API)
├── System.js                          # Runtime stub (throws)
├── System/
│   ├── bindings.json
│   └── internal/
│       ├── index.d.ts
│       └── metadata.json
├── ... (more namespaces)
└── __build/scripts/generate.sh        # Type regeneration script
```

## License

MIT
