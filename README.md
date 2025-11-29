# @tsonic/dotnet

TypeScript type definitions for .NET 10 BCL (Base Class Library).

## Features

- ✅ **Complete .NET 10 BCL coverage** - 130 namespaces, 4,295 types, 50,720 members
- ✅ **camelCase members** - TypeScript-friendly naming conventions
- ✅ **Friendly generic aliases** - Use `List<T>` instead of `List_1<T>`
- ✅ **Branded primitive types** - Typed numbers via `@tsonic/types` (int, long, decimal, etc.)
- ✅ **Full type safety** - Zero TypeScript errors

## Installation

```bash
npm install @tsonic/dotnet @tsonic/types
```

## Usage

### Collections

```typescript
import type { List, Dictionary, HashSet } from "@tsonic/dotnet/System.Collections.Generic";
import type { int, decimal } from "@tsonic/types";

const ages: List<int> = null!;
const prices: Dictionary<string, decimal> = null!;
const uniqueIds: HashSet<int> = null!;
```

### Async Programming

```typescript
import type { Task } from "@tsonic/dotnet/System.Threading.Tasks";
import type { int } from "@tsonic/types";

const asyncResult: Task<int> = null!;
```

### Core Types

```typescript
import type { Nullable, Action, Func } from "@tsonic/dotnet/System";
import type { int } from "@tsonic/types";

const optional: Nullable<int> = null!;
const callback: Action<int> = null!;
const converter: Func<int, string> = null!;
```

### LINQ

```typescript
import type { IEnumerable, IQueryable } from "@tsonic/dotnet/System.Linq";
import type { int } from "@tsonic/types";

const sequence: IEnumerable<int> = null!;
```

## Package Structure

- **130 namespaces** - All major .NET namespaces
- **Flat ESM modules** - Clean import paths
- **Metadata sidecars** - `metadata.json` files for CLR-specific info
- **Support types** - All CLR interop types imported from `@tsonic/types` (ptr, ref, etc.)

## Naming Conventions

- **Types**: PascalCase (matches .NET)
- **Members**: camelCase (TypeScript convention)
- **Generics**: Friendly aliases (`List<T>` vs `List_1<T>`)

## Examples

### File I/O

```typescript
import type { Stream, FileStream } from "@tsonic/dotnet/System.IO";
```

### Networking

```typescript
import type { HttpClient } from "@tsonic/dotnet/System.Net.Http";
import type { IPAddress, Socket } from "@tsonic/dotnet/System.Net";
```

### Serialization

```typescript
import type { JsonSerializer } from "@tsonic/dotnet/System.Text.Json";
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
- `DOTNET_VERSION` - .NET runtime version (default: `10.0.0-rc.1.25451.107`)
- `DOTNET_HOME` - .NET installation directory (default: `$HOME/dotnet`)

### Package Structure

```
@tsonic/dotnet/
├── [Namespace]/           # .NET namespace directories (System, Microsoft, etc.)
│   ├── index.d.ts         # Public type declarations
│   ├── index.js           # ESM module stub
│   ├── bindings.json      # CLR↔TS name mappings
│   └── internal/          # Internal implementation types
├── __internal/            # Extension method buckets
│   └── extensions/
└── __build/               # Build tooling
    └── scripts/
        └── generate.sh    # Type regeneration script
```

## License

MIT
