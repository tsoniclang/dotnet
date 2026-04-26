# @tsonic/dotnet

TypeScript declarations and CLR binding metadata for the .NET 10 base class library.

`@tsonic/dotnet` is a generated binding package. It gives Tsonic projects an
importable TypeScript surface for `Microsoft.NETCore.App` assemblies while the
compiled program still targets the real .NET runtime assemblies.

## Install

```bash
npm install @tsonic/dotnet @tsonic/core
```

## Use with Tsonic

Default CLR workspaces include the BCL binding package in the normal compiler
setup. Import CLR namespaces explicitly:

```ts
import { Console } from "@tsonic/dotnet/System.js";
import { List } from "@tsonic/dotnet/System.Collections.Generic.js";
import type { int } from "@tsonic/core/types.js";

export function main(): void {
  const values = new List<int>();
  values.Add(42);
  Console.WriteLine(values.Count.ToString());
}
```

## Package shape

The package exposes one ESM facade per CLR namespace plus compiler metadata:

```text
@tsonic/dotnet/
  System.d.ts
  System.js
  System/
    bindings.json
    internal/index.d.ts
  System.Collections.Generic.d.ts
  System.Collections.Generic.js
  System.Collections.Generic/
    bindings.json
    internal/index.d.ts
  __internal/extensions/index.d.ts
  families.json
```

- `<Namespace>.d.ts` is the public import facade.
- `<Namespace>.js` is an ESM stub for package resolution.
- `<Namespace>/internal/index.d.ts` contains the full generated declaration surface.
- `<Namespace>/bindings.json` carries CLR identity, overload, receiver, extension,
  nullable, and generic metadata for the Tsonic compiler.
- `__internal/extensions/index.d.ts` contains generated extension-method wrapper
  types used for C#-style `using` semantics.
- `families.json` records multi-arity type families such as `Func`, `Action`, and
  `ValueTuple`.

## Type model

- CLR type and member names are emitted with CLR-faithful casing.
- CLR primitives use `@tsonic/core/types.js` aliases such as `int`, `long`,
  `double`, `bool`, and `char`.
- Generic CLR names keep their arity-safe declarations, with facade aliases for
  common families.
- Delegates emit callable TypeScript types.
- `Task` and `ValueTask` are thenable in TypeScript positions.
- Extension methods are available through generated `ExtensionMethods` helpers.

Example extension-method wrapper:

```ts
import type { ExtensionMethods as Linq } from "@tsonic/dotnet/System.Linq.js";
import type { IEnumerable } from "@tsonic/dotnet/System.Collections.Generic.js";
import type { int } from "@tsonic/core/types.js";

type LinqEnumerable<T> = Linq<IEnumerable<T>>;

declare const values: LinqEnumerable<int>;
const positive = values.Where((value) => value > 0);
```

## Versioning

This repo is versioned by .NET major:

- .NET 10 declarations live under `versions/10/`.
- The npm package is published as `@tsonic/dotnet@10.x`.

## Development

Regenerate the .NET 10 package from a sibling `tsbindgen` checkout:

```bash
npm install
npm run generate:10
```

The generation script requires:

- .NET 10 SDK/runtime
- `../tsbindgen`
- a `Microsoft.NETCore.App` runtime directory selected by `DOTNET_HOME` and
  `DOTNET_VERSION`

Example for a system install:

```bash
DOTNET_HOME=/usr/lib/dotnet DOTNET_VERSION=10.0.5 npm run generate:10
```

## License

MIT
