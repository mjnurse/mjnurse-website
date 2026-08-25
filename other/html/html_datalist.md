---
title: HTML datalist
section: HTML
---

```html
<body>
  <form action="" method="get">
    <label for="fruit">Choose your fruit :</label>
    <input list="fruits" name="fruit" id="fruit">
    <datalist id="fruits">
      <option value="Apple">
      <option value="Orange">
      <option value="Banana">
      <option value="Mango">
      <option value="Avacado">
    </datalist>
    <input type="submit">
  </form>
</body>
```

The `<datalist>` tag specifies a list of pre-defined options which a user can select, with type ahead and auto complete, and also allows the user to type another.


