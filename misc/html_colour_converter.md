---
title: HTML Colour Converter
---

<label for="r">RGB:</label>
<input type="number" id="r" name="r" maxlength=3 min=0 max=255 value=21 onchange="rgbVal(this);">
<input type="number" id="g" name="g" maxlength=3 min=0 max=255 value=87 onchange="rgbVal(this);">
<input type="number" id="b" name="b" maxlength=3 min=0 max=255 value=153 onchange="rgbVal(this);">
<label for="h">HEX:</label>
<input type="text" id="h" name="h" maxlength=6 size=6 value="2978B5" onchange="hexVal(this);">
<hr>

I've found rotating the RGB values around can give some colours that work well together.  Not sure if this has a name...

<div id="c1" style="width: 100%; border: 5px solid white; padding: 0.5em;"></div>
<div id="c2" style="width: 100%; border: 5px solid white; padding: 0.5em;"></div>
<div id="c3" style="width: 100%; border: 5px solid white; padding: 0.5em;"></div>

<script>
  function setColors() {
    let h = document.getElementById('h');
    let rh = h.value.slice(0,2);
    let gh = h.value.slice(2,4);
    let bh = h.value.slice(4,6);

    color = rh + gh + bh;
    document.getElementById('c1').style.backgroundColor = '#' + color;
    document.getElementById('c1').innerHTML = '<span style="color: black">#' +
      color + '</span>&nbsp;<span style="color: white">#' + color + '</span>';
    color = bh + rh + gh;
    document.getElementById('c2').style.backgroundColor = '#' + color;
    document.getElementById('c2').innerHTML = '<span style="color: black">#' +
      color + '</span>&nbsp;<span style="color: white">#' + color + '</span>';
    color = gh + bh + rh;
    document.getElementById('c3').style.backgroundColor = '#' + color;
    document.getElementById('c3').innerHTML = '<span style="color: black">#' +
      color + '</span>&nbsp;<span style="color: white">#' + color + '</span>';
  }

  function rgbVal(input) {
    if (input.value < 0) {
      input.value = 0;
    }
    if (input.value > 255) {
      input.value = 255;
    }
    let r = document.getElementById('r');
    let g = document.getElementById('g');
    let b = document.getElementById('b');
    let h = document.getElementById('h');

    h.value = (
      Number(r.value).toString(16).padStart(2,0) +
      Number(g.value).toString(16).padStart(2,0) +
      Number(b.value).toString(16).padStart(2,0)).toUpperCase();

    setColors();
  } 

  function hexVal(input) {
    if (input.value.length < 6) {
      input.value = input.value.padStart(6, 0);
    }
    input.value = input.value.toUpperCase();
    let r = document.getElementById('r');
    let g = document.getElementById('g');
    let b = document.getElementById('b');
    let h = document.getElementById('h');

    r.value = parseInt('0x' + input.value.slice(0,2));
    g.value = parseInt('0x' + input.value.slice(2,4));
    b.value = parseInt('0x' + input.value.slice(4,6));

    setColors();
  }

  setColors();
</script>

<hr>
