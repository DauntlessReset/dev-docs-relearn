---
title: Demo Page
description: This is a demo page to showcase some of the shortcodes available in Relearn (a Hugo template)
---

### Tables 

| Table | Items | Details |
|---|---|---|
| Item | Item | Item |
| Item | Item | Item |
| Item | Item | Item |

### Icons

{{% icon icon="user-secret" %}}

{{% icon icon="radiation-alt" %}}

{{% icon icon="fighter-jet" %}}

{{% icon icon="satellite-dish" %}}

{{% icon icon="mountain" %}}

## Buttons

{{% button href="https://fontawesome.com/v5/search?m=free" icon="hat-wizard" style="info" %}} Font Awesome Icons {{% /button %}}

### Badge

{{% badge %}} Important {{% /badge %}}

{{% badge color="red" icon="skull" %}} Careful now! {{% /badge %}}

{{% badge color="fuchsia" icon="user-secret" %}} Shh, it's a secret {{% /badge %}}

## Notice

{{% notice style="primary" title="Warning!" icon="bomb" %}}
Don't put My Computer in the recycle bin, it will delete your computer.
{{% /notice %}}

## Tabs 

{{< tabs >}}
{{% tab name ="Python" %}}
```
for i in range(1, 11):
    print(i)
```


{{% /tabs %}}
{{% tab name = Java %}}

```
for (int i=1; i<=10: i++) {
    System.out.println(i);
}
```

{{% /tabs %}}
{{< /tabs >}}
