# capacitor-apple-watch-cap-2

Apple watch connectivity capacitor v2 plugin

## Install

```bash
npm install capacitor-apple-watch-cap-2
npx cap sync
```

## API

<docgen-index>

* [`echo(...)`](#echo)
* [`sendMessage(...)`](#sendmessage)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### echo(...)

```typescript
echo(options: { value: string; }) => Promise<{ value: string; }>
```

| Param         | Type                            |
| ------------- | ------------------------------- |
| **`options`** | <code>{ value: string; }</code> |

**Returns:** <code>Promise&lt;{ value: string; }&gt;</code>

--------------------


### sendMessage(...)

```typescript
sendMessage(options: { messageId: string; message: []; }) => Promise<void>
```

| Param         | Type                                             |
| ------------- | ------------------------------------------------ |
| **`options`** | <code>{ messageId: string; message: []; }</code> |

--------------------

</docgen-api>

