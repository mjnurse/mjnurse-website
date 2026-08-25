---
title: Copy to Clipboard
---

In this particular use case, the function takes a path plus name for a page on my website and then copies to the clipboard a command to edit the page source using gvim.  I click on the name of the page in the page in the browser I want to edit, and then press press the windows key, CTRL-V and return to edit the page source.

```javascript
function copyToClipboard(pathAndName) {
  const el = document.createElement('textarea');
  el.value =
    ('gvim C:/MJN/github/mjnurse-github-io/' + pathAndName).replace(/\//g, '\\');
  alert(el.value + ' copied to clipboard');
  document.body.appendChild(el);
  el.select();
  document.execCommand('copy');
  document.body.removeChild(el);
}
```


<hr>
