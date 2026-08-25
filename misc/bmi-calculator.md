---
title: BMI Calculator
---
## Weight
<p><input type="text" id="st" name="st" min=0 size=3 autofocus onchange="stChng(this);">
<label for="st">St</label>
<input type="text" id="lb" name="lb" min=0 size=3 onchange="stChng(this);">
<label for="lb">Lb</label></p>
<p><input type="text" id="lbs" name="lbs" min=0 size=3 onchange="lbsChng(this);">
<label for="kg">lbs</label></p>
<p><input type="text" id="kg" name="kg" min=0 size=3 onchange="kgChng(this);">
<label for="kg">Kg</label></p>
<hr>
## Height
<p><input type="text" id="ft" name="ft" min=0 size=3 onchange="ftChng(this);">
<label for="st">Ft</label>
<input type="text" id="in" name="in" min=0 size=3 onchange="ftChng(this);">
<label for="lb">In</label></p>
<p><input type="text" id="m" name="m" min=0 size=3 onchange="mChng(this);">
<label for="m">m</label></p>
<hr>
## Target Weight
<p>Current BMI: <span id="bmi">0</span></p>
<p>Target Weight (BMI 20 - 25)</p>

<table>
  <tr><td></td><th>BMI 20 weight (lose/gain)</th><th>BMI 25 weight (lose/gain)</th></tr>
  <tr><th>Kg</th><td><span id="bmi20Kg">0</span></td><td><span id="bmi25Kg">0</span></td></tr>
  <tr><th>Lbs</th><td><span id="bmi20Lbs">0</span></td><td><span id="bmi25Lbs">0</span></td></tr>
  <tr><th>St Lb</th><td><span id="bmi20StLb">0</span></td><td><span id="bmi25StLb">0</span></td></tr>
</table>
<p id="message1"></p>
<hr>
**Notes:**

- BMI for adults only.  Doesn't account for body / bone structure, other formulae exist.

- BMI <20: Underweight. BMI 20-25: Healthy weight. BMI 25-30: Over Weight. BMI 30-35: Obese. BMI>35 very/morbidly obese.

<script>
function getFloat(id) {
  return parseFloat(document.getElementById(id).value) || 0;
}

function setValue(id, value) {
  document.getElementById(id).value = value;
}

function setHTML(id, html) {
  document.getElementById(id).innerHTML = html;
}

function lbsToStLb(lbs) {
  return [Math.floor(lbs / 14), Math.round(lbs % 14)];
}

function stLbToLbs(st, lb) {
  return st * 14 + lb;
}

function bmiCategory(bmi) {
  if (bmi < 20) return 'Under weight';
  if (bmi < 25) return 'Healthy weight';
  if (bmi < 30) return 'Over weight';
  if (bmi < 35) return 'Obese';
  return 'Very / morbidly obese';
}

function bmiChng() {
  const st = getFloat('st');
  const lb = getFloat('lb');
  const lbs = getFloat('lbs');
  const kg = getFloat('kg');
  const m = getFloat('m');

  const bmiVal = kg / (m * m);
  const bmi20Kg = 20 * m * m;
  const bmi25Kg = 25 * m * m;
  const bmi20DiffKg = bmi20Kg - kg;
  const bmi25DiffKg = bmi25Kg - kg;

  const bmi20Lbs = bmi20Kg * 2.20462;
  const bmi25Lbs = bmi25Kg * 2.20462;
  const bmi20DiffLbs = bmi20Lbs - lbs;
  const bmi25DiffLbs = bmi25Lbs - lbs;

  const [bmi20St, bmi20Lb] = lbsToStLb(bmi20Lbs);
  const [bmi25St, bmi25Lb] = lbsToStLb(bmi25Lbs);
  const stLbInput = stLbToLbs(st, lb);
  const bmi20DiffStLb = bmi20St * 14 + bmi20Lb - stLbInput;
  const bmi25DiffStLb = bmi25St * 14 + bmi25Lb - stLbInput;

  const formatDiff = diff => {
    const sign = diff < 0 ? -1 : 1;
    const abs = Math.abs(diff);
    return [sign * Math.floor(abs / 14), sign * Math.floor(abs % 14)];
  };

  const [bmi20StDiff, bmi20LbDiff] = formatDiff(bmi20DiffStLb);
  const [bmi25StDiff, bmi25LbDiff] = formatDiff(bmi25DiffStLb);

  setHTML('bmi', `<b>${bmiVal.toFixed(1)}</b> - Category: <b>${bmiCategory(bmiVal)}</b>`);
  setHTML('bmi20Kg', `${bmi20Kg.toFixed(1)} (${bmi20DiffKg.toFixed(1)})`);
  setHTML('bmi25Kg', `${bmi25Kg.toFixed(1)} (${bmi25DiffKg.toFixed(1)})`);
  setHTML('bmi20Lbs', `${bmi20Lbs.toFixed(1)} (${bmi20DiffLbs.toFixed(1)})`);
  setHTML('bmi25Lbs', `${bmi25Lbs.toFixed(1)} (${bmi25DiffLbs.toFixed(1)})`);

  setHTML('bmi20StLb', `${bmi20St}st ${bmi20Lb}lb (${bmi20StDiff}st ${Math.abs(bmi20LbDiff)}lb)`);
  setHTML('bmi25StLb', `${bmi25St}st ${bmi25Lb}lb (${bmi25StDiff}st ${Math.abs(bmi25LbDiff)}lb)`);

  const message = bmi25DiffKg < 0
    ? `<hr><p>To get to a target BMI of <b>25</b> you need to lose <b>${(-bmi25DiffKg).toFixed(1)}kg (${(-bmi25DiffStLb).toFixed(1)}lbs).</b></p>
       <p>This volume of fat is roughly the same as <b>${((-bmi25DiffKg / 0.9) * 3.13).toFixed(0)} cans of coke.</b></p>
       <p>This is roughly <b>${(-bmi25DiffKg * 7778).toFixed(0)}</b> calories.</p>`
    : '';

  setHTML('message1', message);
}

function ftChng() {
  const ft = getFloat('ft');
  const inch = getFloat('in');
  const mVal = ((ft * 12 + inch) * 0.0254).toFixed(2);
  setValue('m', mVal);
  bmiChng();
}

function mChng() {
  const m = getFloat('m');
  const totalInches = m / 0.0254;
  setValue('ft', Math.floor(totalInches / 12));
  setValue('in', Math.round(totalInches % 12));
  bmiChng();
}

function stChng() {
  const st = getFloat('st');
  const lb = getFloat('lb');
  const lbsVal = stLbToLbs(st, lb);
  setValue('lbs', lbsVal);
  setValue('kg', (lbsVal / 2.20462).toFixed(1));
  bmiChng();
}

function lbsChng() {
  const lbs = getFloat('lbs');
  const [stVal, lbVal] = lbsToStLb(lbs);
  setValue('st', stVal);
  setValue('lb', lbVal);
  setValue('kg', (lbs / 2.20462).toFixed(1));
  bmiChng();
}

function kgChng() {
  const kg = getFloat('kg');
  const lbsVal = kg * 2.20462;
  const [stVal, lbVal] = lbsToStLb(lbsVal);
  setValue('st', stVal);
  setValue('lb', lbVal);
  setValue('lbs', lbsVal.toFixed(1));
  bmiChng();
}
</script>
<hr>
