const WORM = [
  'r105c101', 'r105c105', 'r105c108', 'r105c111', 'r105c112', 'r105c113',
  'r105c117', 'r105c119', 'r106c101', 'r106c105', 'r106c107', 'r106c109',
  'r106c111', 'r106c114', 'r106c116', 'r106c118', 'r106c120', 'r107c101',
  'r107c103', 'r107c105', 'r107c107', 'r107c109', 'r107c111', 'r107c112',
  'r107c113', 'r107c116', 'r107c118', 'r107c120', 'r108c101', 'r108c103',
  'r108c105', 'r108c107', 'r108c109', 'r108c111', 'r108c113', 'r108c116',
  'r108c120', 'r109c102', 'r109c104', 'r109c108', 'r109c111', 'r109c114',
  'r109c116', 'r109c120'];

const GAME_OVER = [
  'r105c103', 'r105c104', 'r105c105', 'r105c108', 'r105c112', 'r105c114',
  'r105c117', 'r105c118', 'r105c119', 'r106c102', 'r106c107', 'r106c109',
  'r106c111', 'r106c113', 'r106c115', 'r106c117', 'r107c102', 'r107c104',
  'r107c105', 'r107c107', 'r107c108', 'r107c109', 'r107c111', 'r107c113',
  'r107c115', 'r107c117', 'r107c118', 'r108c102', 'r108c105', 'r108c107',
  'r108c109', 'r108c111', 'r108c115', 'r108c117', 'r109c103', 'r109c104',
  'r109c107', 'r109c109', 'r109c111', 'r109c115', 'r109c117', 'r109c118',
  'r109c119', 'r111c103', 'r111c106', 'r111c110', 'r111c112', 'r111c113',
  'r111c114', 'r111c116', 'r111c117', 'r111c118', 'r112c102', 'r112c104',
  'r112c106', 'r112c110', 'r112c112', 'r112c116', 'r112c119', 'r113c102',
  'r113c104', 'r113c107', 'r113c109', 'r113c112', 'r113c113', 'r113c116',
  'r113c117', 'r113c118', 'r114c102', 'r114c104', 'r114c107', 'r114c109',
  'r114c112', 'r114c116', 'r114c118', 'r115c103', 'r115c108', 'r115c112',
  'r115c113', 'r115c114', 'r115c116', 'r115c119'];

var CANVASXX = {
  max_rows : 20,
  max_cols : 20,
  canvas : [],
  CANVASXX : function() {
    for (let row=1; row<=max_rows; row++) {
      canvas[row] = new Array(max_cols+1);
      for (let col=1; col<=max_cols; col++) {
        canvas[row][col] = 'E';
        console.log(col);
      }
    }
  }
}

const INTERVAL_MS = 100;
const BLANK = 'images/blank.png';
const CRASH = 'images/crash.png';
const BODY = 'images/body.png';
const FOOD = 'images/food.png';

let IMAGE_SIZE = 20;
let KEYPRESSES ='';
let CANVAS;
let SCORE = 0;
let GAME_STATUS = 'Stopped';
let THE_INTERVAL;
let TAILBUFFERSTR;
let HEAD_ROW = 10;
let HEAD_COL = 10;
let MOVE_COL = 1;
let MOVE_ROW = 0;

function createCanvas() {
  const canvasDiv = document.getElementById('canvas');
  IMAGE_SIZE = 20;
  CANVAS = new Array(MAX_ROWS+1);
  // if (canvasDiv.style.width < (MAX_COLS*IMAGE_SIZE)) {
  // IMAGE_SIZE = canvasDiv.style.width/MAX_COLS;
  // }
  canvasDiv.innerHTML = '';
  for (let row=1; row<=MAX_ROWS; row++) {
    CANVAS[row] = new Array(MAX_COLS+1);
    for (let col=1; col<=MAX_COLS; col++) {
      CANVAS[row][col] = 'E';
      canvasDiv.innerHTML +=
         '<img id="r'+(100+row)+'c'+(100+col)+'" width="'+IMAGE_SIZE+'"></img>';
    }
    canvasDiv.innerHTML += '<br>';
  }
  clearCanvas();
  displayWormText();
  const text = document.getElementById('topText');
  text.innerHTML = 'Press P to Play';
}

function clearCanvas() {
  let pos;
  const text = document.getElementById('topText');
  for (let row=1; row<=MAX_ROWS; row++) {
    for (let col=1; col<=MAX_COLS; col++) {
      pos = document.getElementById('r'+(100+row)+'c'+(100+col));
      pos.src = BLANK;
      CANVAS[row][col] = 'E';
    }
  }
}

function displayWormText() {
  let pos;
  for (let i=0; i<WORM.length; i++) {
    let pos = document.getElementById(WORM[i]);
    pos.src = BODY;
  }
}

function displayGameOverText() {
  let pos;
  for (let i=0; i<GAME_OVER.length; i++) {
    let pos = document.getElementById(GAME_OVER[i]);
    pos.src = CRASH;
  }
}

function gameOver() {
  clearInterval(THE_INTERVAL);
  GAME_STATUS = 'Stopped';
  const text = document.getElementById('topText');
  text.innerHTML = 'Press P to Play';
  displayGameOverText();
}

function start() {
  if (GAME_STATUS == 'Running') {
    return;
  }
  GAME_STATUS = 'Running';
  const text = document.getElementById('topText');
  text.innerHTML = 'Press P to Pause, Q to Quit';
  TAILBUFFERSTR = 'r110c110';
  HEAD_ROW = 10;
  HEAD_COL = 10;
  MOVE_COL = 1;
  MOVE_ROW = 0;
  clearCanvas();
  addFood();
  addFood();
  addFood();
  THE_INTERVAL = setInterval(wormMain, INTERVAL_MS);
  SCORE = 0;
  showScore();
}

function showScore() {
  const text = document.getElementById('bottomText');
  text.innerHTML = 'Score: ' + SCORE;
}

function addFood() {
  let col;
  let row;

  for (let i=1; i<=10000; row++) {
    col = Math.floor(Math.random()*(MAX_COLS-1))+1;
    row = Math.floor(Math.random()*(MAX_ROWS-1))+1;
    if (CANVAS[row][col] == 'E') {
      CANVAS[row][col] = 'F';
      let pos = document.getElementById('r'+(100+row)+'c'+(100+col));
      pos.src = FOOD;
      return;
    }
  }
}

function wormMain() {
  const tailEndRow = TAILBUFFERSTR.substring(1, 4)-100;
  const tailEndcol = TAILBUFFERSTR.substring(5, 8)-100;
  let prev = document.getElementById('r'+(100+tailEndRow)+'c'+(100+tailEndcol));

  if (KEYPRESSES != '') {
    switch (KEYPRESSES.substring(0, 1)) {
      case 'U':
        if (MOVE_ROW == 0) {
          MOVE_ROW = -1; MOVE_COL = 0;
        } break;
      case 'D':
        if (MOVE_ROW == 0) {
          MOVE_ROW = 1; MOVE_COL = 0;
        } break;
      case 'L':
        if (MOVE_COL == 0) {
          MOVE_ROW = 0; MOVE_COL = -1;
        } break;
      case 'R':
        if (MOVE_COL == 0) {
          MOVE_ROW = 0; MOVE_COL = 1;
        } break;
    }
    KEYPRESSES = KEYPRESSES.substring(1, 99999);
  }
  CANVAS[tailEndRow][tailEndcol] = 'E';
  HEAD_ROW += MOVE_ROW;
  HEAD_COL += MOVE_COL;
  if (HEAD_ROW > MAX_ROWS) {
    HEAD_ROW = 1;
  }
  if (HEAD_COL > MAX_COLS) {
    HEAD_COL = 1;
  }
  if (HEAD_ROW < 1) {
    HEAD_ROW = MAX_ROWS;
  }
  if (HEAD_COL < 1) {
    HEAD_COL = MAX_COLS;
  }
  TAILBUFFERSTR += 'r'+(100+HEAD_ROW)+'c'+(100+HEAD_COL);
  let curr = document.getElementById('r'+(100+HEAD_ROW)+'c'+(100+HEAD_COL));
  if (CANVAS[HEAD_ROW][HEAD_COL] == 'S') {
    gameOver();
    return;
  }
  if (CANVAS[HEAD_ROW][HEAD_COL] == 'F') {
    SCORE++;
    showScore();
    addFood();
  } else {
    TAILBUFFERSTR = TAILBUFFERSTR.substring(8, 99999);
  }
  CANVAS[HEAD_ROW][HEAD_COL] = 'S';
  curr.src = BODY;
  prev.src = BLANK;
}

function addKeyListener() {
  document.addEventListener('keydown', function() {
    if (event.ctrlKey) {
      return;
    }
    keyVal = event.keyCode;
    event.preventDefault();
    switch (keyVal) {
      case 38:
        KEYPRESSES = 'U';
        break;
      case 40:
        KEYPRESSES += 'D';
        break;
      case 37:
        KEYPRESSES += 'L';
        break;
      case 39:
        KEYPRESSES += 'R';
        break;
      case 80:
        if (GAME_STATUS == 'Running') {
          clearInterval(THE_INTERVAL);
          GAME_STATUS = 'Paused';
          const text = document.getElementById('topText');
          text.innerHTML = 'PAUSED - Press P Unpause, Q to Quit';
        } else if (GAME_STATUS == 'Paused') {
          THE_INTERVAL = setInterval(wormMain, INTERVAL_MS);
          GAME_STATUS = 'Running';
          const text = document.getElementById('topText');
          text.innerHTML = 'Press P to Pause, Q to Quit';
        } else {
          start();
        }
        break;
      case 81:
        gameOver();
        break;
    }
  });
}
