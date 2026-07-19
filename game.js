/**
 * KenKen Puzzle Game
 * Supports 4×4 and 6×6 grids.
 * Puzzles are pre-defined with known solutions so the game is always solvable.
 *
 * Puzzle format:
 *   { size, solution, cages }
 *   cage: { cells: [[r,c],...], op: '+' | '-' | '×' | '÷' | '=', target }
 *   op '=' means a single-cell "given" cage.
 */

'use strict';

/* ═══════════════════════════════════════════════════════════════
   PRE-DEFINED PUZZLES  (all verified: valid Latin squares + correct cage clues)
═══════════════════════════════════════════════════════════════ */

const PUZZLES = {

  /* ── 4×4 puzzles ─────────────────────────────────────────── */
  4: [
    {
      size: 4,
      solution: [
        [2, 1, 4, 3],
        [3, 4, 1, 2],
        [4, 2, 3, 1],
        [1, 3, 2, 4],
      ],
      cages: [
        { cells: [[0,0],[0,1]],       op: '+', target: 3  }, // 2+1
        { cells: [[0,2],[0,3],[1,3]], op: '+', target: 9  }, // 4+3+2
        { cells: [[1,0],[2,0]],       op: '+', target: 7  }, // 3+4
        { cells: [[1,1],[1,2]],       op: '×', target: 4  }, // 4×1
        { cells: [[2,1],[3,1]],       op: '+', target: 5  }, // 2+3
        { cells: [[2,2],[2,3]],       op: '-', target: 2  }, // 3-1
        { cells: [[3,0]],             op: '=', target: 1  }, // 1
        { cells: [[3,2],[3,3]],       op: '+', target: 6  }, // 2+4
      ],
    },
    {
      size: 4,
      solution: [
        [1, 2, 3, 4],
        [2, 1, 4, 3],
        [3, 4, 1, 2],
        [4, 3, 2, 1],
      ],
      cages: [
        { cells: [[0,0],[1,0]],       op: '+', target: 3  }, // 1+2
        { cells: [[0,1],[0,2]],       op: '×', target: 6  }, // 2×3
        { cells: [[0,3],[1,3]],       op: '+', target: 7  }, // 4+3
        { cells: [[1,1],[1,2]],       op: '-', target: 3  }, // 4-1
        { cells: [[2,0],[2,1]],       op: '+', target: 7  }, // 3+4
        { cells: [[2,2],[3,2]],       op: '×', target: 2  }, // 1×2
        { cells: [[2,3],[3,3]],       op: '+', target: 3  }, // 2+1
        { cells: [[3,0],[3,1]],       op: '+', target: 7  }, // 4+3
      ],
    },
  ],

  /* ── 6×6 puzzles ─────────────────────────────────────────── */
  6: [
    {
      size: 6,
      // Verified Latin square
      solution: [
        [5, 6, 3, 4, 1, 2],
        [6, 1, 4, 5, 2, 3],
        [3, 5, 6, 2, 4, 1],
        [4, 2, 1, 6, 3, 5],
        [2, 3, 5, 1, 6, 4],
        [1, 4, 2, 3, 5, 6],
      ],
      cages: [
        { cells: [[0,0],[0,1]],           op: '+', target: 11 }, // 5+6
        { cells: [[0,2],[1,2]],           op: '+', target: 7  }, // 3+4
        { cells: [[0,3],[0,4],[0,5]],     op: '+', target: 7  }, // 4+1+2
        { cells: [[1,0],[2,0]],           op: '+', target: 9  }, // 6+3
        { cells: [[1,1],[2,1]],           op: '-', target: 4  }, // 5-1
        { cells: [[1,3],[1,4]],           op: '×', target: 10 }, // 5×2
        { cells: [[1,5],[2,5]],           op: '+', target: 4  }, // 3+1
        { cells: [[2,2],[3,2]],           op: '+', target: 7  }, // 6+1
        { cells: [[2,3],[3,3]],           op: '+', target: 8  }, // 2+6
        { cells: [[2,4],[3,4]],           op: '+', target: 7  }, // 4+3
        { cells: [[3,0],[4,0]],           op: '+', target: 6  }, // 4+2
        { cells: [[3,1],[4,1]],           op: '+', target: 5  }, // 2+3
        { cells: [[3,5],[4,5]],           op: '+', target: 9  }, // 5+4
        { cells: [[4,2],[5,2]],           op: '+', target: 7  }, // 5+2
        { cells: [[4,3],[5,3]],           op: '+', target: 4  }, // 1+3
        { cells: [[4,4],[5,4]],           op: '+', target: 11 }, // 6+5
        { cells: [[5,0],[5,1]],           op: '+', target: 5  }, // 1+4
        { cells: [[5,5]],                 op: '=', target: 6  }, // 6
      ],
    },
    {
      size: 6,
      // Cyclic Latin square
      solution: [
        [1, 2, 3, 4, 5, 6],
        [2, 3, 4, 5, 6, 1],
        [3, 4, 5, 6, 1, 2],
        [4, 5, 6, 1, 2, 3],
        [5, 6, 1, 2, 3, 4],
        [6, 1, 2, 3, 4, 5],
      ],
      cages: [
        { cells: [[0,0],[1,0]],           op: '+', target: 3  }, // 1+2
        { cells: [[0,1],[0,2]],           op: '+', target: 5  }, // 2+3
        { cells: [[0,3],[0,4],[0,5]],     op: '+', target: 15 }, // 4+5+6
        { cells: [[1,1],[2,1]],           op: '+', target: 7  }, // 3+4
        { cells: [[1,2],[1,3]],           op: '+', target: 9  }, // 4+5
        { cells: [[1,4],[2,4]],           op: '+', target: 7  }, // 6+1
        { cells: [[1,5],[2,5]],           op: '+', target: 3  }, // 1+2
        { cells: [[2,0],[3,0]],           op: '+', target: 7  }, // 3+4
        { cells: [[2,2],[3,2]],           op: '+', target: 11 }, // 5+6
        { cells: [[2,3],[3,3]],           op: '+', target: 7  }, // 6+1
        { cells: [[3,1],[4,1]],           op: '+', target: 11 }, // 5+6
        { cells: [[3,4],[4,4]],           op: '+', target: 5  }, // 2+3
        { cells: [[3,5],[4,5]],           op: '+', target: 7  }, // 3+4
        { cells: [[4,0],[5,0]],           op: '+', target: 11 }, // 5+6
        { cells: [[4,2],[5,2]],           op: '+', target: 3  }, // 1+2
        { cells: [[4,3],[5,3]],           op: '+', target: 5  }, // 2+3
        { cells: [[5,1]],                 op: '=', target: 1  }, // 1
        { cells: [[5,4],[5,5]],           op: '+', target: 9  }, // 4+5
      ],
    },
    {
      size: 6,
      // A third 6×6 puzzle with more varied operators
      solution: [
        [4, 1, 6, 2, 5, 3],
        [5, 6, 2, 3, 1, 4],
        [1, 2, 5, 4, 3, 6],
        [6, 3, 4, 1, 2, 5],
        [2, 5, 1, 6, 4, 3],  // fixed: was [2,5,3,6,4,3] — col 2 had duplicate
        [3, 4, 3, 5, 6, 1],  // placeholder — replaced below
      ],
      // Replaced with a clean verified solution:
      cages: [], // filled after override
    },
  ],
};

// Override puzzle index 2 with a clean verified 6×6
PUZZLES[6][2] = {
  size: 6,
  // Verified Latin square (Cayley table style)
  solution: [
    [4, 1, 6, 2, 5, 3],
    [5, 6, 2, 3, 1, 4],
    [1, 2, 5, 4, 3, 6],
    [6, 3, 4, 1, 2, 5],
    [3, 5, 1, 6, 4, 2],
    [2, 4, 3, 5, 6, 1],
  ],
  cages: [
    { cells: [[0,0],[1,0]],           op: '+', target: 9  }, // 4+5
    { cells: [[0,1],[0,2]],           op: '-', target: 5  }, // 6-1
    { cells: [[0,3],[0,4]],           op: '×', target: 10 }, // 2×5
    { cells: [[0,5],[1,5]],           op: '+', target: 7  }, // 3+4
    { cells: [[1,1],[2,1]],           op: '+', target: 8  }, // 6+2
    { cells: [[1,2],[1,3]],           op: '+', target: 5  }, // 2+3
    { cells: [[1,4],[2,4]],           op: '+', target: 4  }, // 1+3
    { cells: [[2,0],[3,0]],           op: '+', target: 7  }, // 1+6
    { cells: [[2,2],[3,2]],           op: '+', target: 9  }, // 5+4
    { cells: [[2,3],[3,3]],           op: '+', target: 5  }, // 4+1
    { cells: [[2,5],[3,5]],           op: '+', target: 11 }, // 6+5
    { cells: [[3,1],[4,1]],           op: '+', target: 8  }, // 3+5
    { cells: [[3,4],[4,4]],           op: '+', target: 6  }, // 2+4
    { cells: [[4,0],[5,0]],           op: '+', target: 5  }, // 3+2
    { cells: [[4,2],[5,2]],           op: '+', target: 4  }, // 1+3
    { cells: [[4,3],[5,3]],           op: '+', target: 11 }, // 6+5
    { cells: [[4,5],[5,5]],           op: '+', target: 3  }, // 2+1
    { cells: [[5,1],[5,4]],           op: '+', target: 10 }, // 4+6
  ],
};

/* ═══════════════════════════════════════════════════════════════
   GAME STATE
═══════════════════════════════════════════════════════════════ */
let state = {
  size: 6,
  puzzle: null,       // current puzzle object
  grid: [],           // 2-D array of user values (0 = empty)
  selected: null,     // { r, c }
  timerInterval: null,
  seconds: 0,
  solved: false,
};

/* ═══════════════════════════════════════════════════════════════
   UTILITY
═══════════════════════════════════════════════════════════════ */
function $(id) { return document.getElementById(id); }

function pickRandom(arr) {
  return arr[Math.floor(Math.random() * arr.length)];
}

function padTwo(n) { return String(n).padStart(2, '0'); }

/* ═══════════════════════════════════════════════════════════════
   TIMER
═══════════════════════════════════════════════════════════════ */
function startTimer() {
  stopTimer();
  state.seconds = 0;
  updateTimerDisplay();
  state.timerInterval = setInterval(() => {
    if (!state.solved) {
      state.seconds++;
      updateTimerDisplay();
    }
  }, 1000);
}

function stopTimer() {
  if (state.timerInterval) {
    clearInterval(state.timerInterval);
    state.timerInterval = null;
  }
}

function updateTimerDisplay() {
  const m = Math.floor(state.seconds / 60);
  const s = state.seconds % 60;
  $('timer').textContent = `${padTwo(m)}:${padTwo(s)}`;
}

/* ═══════════════════════════════════════════════════════════════
   CAGE HELPERS
═══════════════════════════════════════════════════════════════ */

/** Build a map: "r,c" → cage index */
function buildCageMap(cages) {
  const map = {};
  cages.forEach((cage, idx) => {
    cage.cells.forEach(([r, c]) => { map[`${r},${c}`] = idx; });
  });
  return map;
}

/**
 * For each cell, determine which of its 4 borders should be THICK
 * (i.e., the neighbour in that direction belongs to a different cage).
 */
function computeBorders(size, cageMap) {
  const borders = {};
  for (let r = 0; r < size; r++) {
    for (let c = 0; c < size; c++) {
      const key = `${r},${c}`;
      const cageIdx = cageMap[key];
      const b = { top: false, right: false, bottom: false, left: false };

      if (r === 0           || cageMap[`${r-1},${c}`] !== cageIdx) b.top    = true;
      if (r === size - 1    || cageMap[`${r+1},${c}`] !== cageIdx) b.bottom = true;
      if (c === 0           || cageMap[`${r},${c-1}`] !== cageIdx) b.left   = true;
      if (c === size - 1    || cageMap[`${r},${c+1}`] !== cageIdx) b.right  = true;

      borders[key] = b;
    }
  }
  return borders;
}

/** Find the top-left cell of a cage (for placing the clue label) */
function topLeftCell(cells) {
  return cells.reduce((best, [r, c]) => {
    if (r < best[0] || (r === best[0] && c < best[1])) return [r, c];
    return best;
  }, cells[0]);
}

/* ═══════════════════════════════════════════════════════════════
   RENDER
═══════════════════════════════════════════════════════════════ */
function renderGrid() {
  const { size, puzzle, grid, selected } = state;
  const gridEl = $('grid');
  gridEl.innerHTML = '';

  // Responsive cell size
  const maxW = Math.min(window.innerWidth - 48, 560);
  const cellSize = Math.floor((maxW - (size + 1) * 2) / size);

  gridEl.style.gridTemplateColumns = `repeat(${size}, ${cellSize}px)`;

  const cageMap  = buildCageMap(puzzle.cages);
  const borders  = computeBorders(size, cageMap);

  // Which cell in each cage gets the clue label (top-left of cage)
  const labelCells = new Set();
  puzzle.cages.forEach(cage => {
    const [lr, lc] = topLeftCell(cage.cells);
    labelCells.add(`${lr},${lc}`);
  });

  for (let r = 0; r < size; r++) {
    for (let c = 0; c < size; c++) {
      const key  = `${r},${c}`;
      const cell = document.createElement('div');
      cell.className    = 'cell';
      cell.dataset.r    = r;
      cell.dataset.c    = c;
      cell.style.width  = `${cellSize}px`;
      cell.style.height = `${cellSize}px`;

      // Cage borders
      const b = borders[key];
      if (b.top)    cell.classList.add('border-top');
      if (b.right)  cell.classList.add('border-right');
      if (b.bottom) cell.classList.add('border-bottom');
      if (b.left)   cell.classList.add('border-left');

      // Cage clue label
      if (labelCells.has(key)) {
        const cage  = puzzle.cages[cageMap[key]];
        const label = document.createElement('span');
        label.className   = 'cage-label';
        label.textContent = cage.op === '=' ? cage.target : `${cage.target}${cage.op}`;
        cell.appendChild(label);
      }

      // User-entered value
      const val = grid[r][c];
      if (val !== 0) {
        const span = document.createElement('span');
        span.className   = 'cell-value';
        span.textContent = val;
        cell.appendChild(span);
      }

      // Selection highlight
      if (selected && selected.r === r && selected.c === c) {
        cell.classList.add('selected');
      }

      cell.addEventListener('click', () => selectCell(r, c));
      gridEl.appendChild(cell);
    }
  }
}

function renderNumpad() {
  const pad = $('numpad');
  pad.innerHTML = '';
  for (let n = 1; n <= state.size; n++) {
    const btn = document.createElement('button');
    btn.className   = 'num-btn';
    btn.textContent = n;
    btn.addEventListener('click', () => enterValue(n));
    pad.appendChild(btn);
  }
  const clr = document.createElement('button');
  clr.className   = 'num-btn clear-btn';
  clr.textContent = '✕ Clear';
  clr.addEventListener('click', () => enterValue(0));
  pad.appendChild(clr);
}

/* ═══════════════════════════════════════════════════════════════
   INTERACTION
═══════════════════════════════════════════════════════════════ */
function selectCell(r, c) {
  state.selected = { r, c };
  renderGrid();
}

function enterValue(val) {
  if (!state.selected || state.solved) return;
  const { r, c } = state.selected;
  state.grid[r][c] = val;
  renderGrid();
}

/* ═══════════════════════════════════════════════════════════════
   VALIDATION
═══════════════════════════════════════════════════════════════ */
function evaluateCage(cage, grid) {
  const vals = cage.cells.map(([r, c]) => grid[r][c]);
  if (vals.some(v => v === 0)) return null; // incomplete — skip

  if (cage.op === '=') return vals[0] === cage.target;
  if (cage.op === '+') return vals.reduce((a, b) => a + b, 0) === cage.target;
  if (cage.op === '×') return vals.reduce((a, b) => a * b, 1) === cage.target;
  if (cage.op === '-') return Math.abs(vals[0] - vals[1]) === cage.target;
  if (cage.op === '÷') {
    const [a, b] = vals;
    return (a / b === cage.target) || (b / a === cage.target);
  }
  return false;
}

function checkSolution() {
  const { size, puzzle, grid } = state;

  // Must be fully filled
  for (let r = 0; r < size; r++) {
    for (let c = 0; c < size; c++) {
      if (grid[r][c] === 0) {
        showMessage('The puzzle is not complete yet — fill in all cells first.', 'info');
        return;
      }
    }
  }

  // Validate rows & columns
  let rowColOk = true;
  const expected = Array.from({ length: size }, (_, k) => k + 1).join(',');
  for (let i = 0; i < size; i++) {
    const row = [...grid[i]].sort((a, b) => a - b).join(',');
    const col = grid.map(r => r[i]).sort((a, b) => a - b).join(',');
    if (row !== expected || col !== expected) { rowColOk = false; break; }
  }

  // Validate cages
  const cageResults = puzzle.cages.map(cage => evaluateCage(cage, grid));
  const cagesOk     = cageResults.every(r => r === true);

  // Colour cells by cage result
  const cageMap = buildCageMap(puzzle.cages);
  document.querySelectorAll('.cell').forEach(cell => {
    cell.classList.remove('correct', 'incorrect');
    const r       = +cell.dataset.r;
    const c       = +cell.dataset.c;
    const result  = cageResults[cageMap[`${r},${c}`]];
    if (result === true)  cell.classList.add('correct');
    if (result === false) cell.classList.add('incorrect');
  });

  if (rowColOk && cagesOk) {
    state.solved = true;
    stopTimer();
    const m = Math.floor(state.seconds / 60);
    const s = state.seconds % 60;
    showMessage(`🎉 Congratulations! Puzzle solved in ${padTwo(m)}:${padTwo(s)}!`, 'success');
  } else {
    showMessage('Not quite right — incorrect cages are highlighted in red.', 'error');
  }
}

function revealSolution() {
  const { size, puzzle } = state;
  state.solved = true;
  stopTimer();
  for (let r = 0; r < size; r++) {
    for (let c = 0; c < size; c++) {
      state.grid[r][c] = puzzle.solution[r][c];
    }
  }
  renderGrid();
  document.querySelectorAll('.cell').forEach(cell => cell.classList.add('revealed'));
  showMessage('Solution revealed. Start a new puzzle to play again!', 'info');
}

/* ═══════════════════════════════════════════════════════════════
   MESSAGE BOX
═══════════════════════════════════════════════════════════════ */
function showMessage(text, type) {
  const box = $('message-box');
  box.textContent = text;
  box.className   = type; // clears 'hidden'
}

function hideMessage() {
  $('message-box').className = 'hidden';
}

/* ═══════════════════════════════════════════════════════════════
   NEW GAME
═══════════════════════════════════════════════════════════════ */
function newGame() {
  const size    = parseInt($('difficulty').value, 10);
  state.size    = size;
  state.puzzle  = pickRandom(PUZZLES[size]);
  state.grid    = Array.from({ length: size }, () => Array(size).fill(0));
  state.selected = null;
  state.solved   = false;

  $('size-label').textContent = size;
  hideMessage();
  renderGrid();
  renderNumpad();
  startTimer();
}

/* ═══════════════════════════════════════════════════════════════
   KEYBOARD SUPPORT
═══════════════════════════════════════════════════════════════ */
document.addEventListener('keydown', e => {
  if (state.solved) return;
  const { key } = e;

  // Digit entry
  if (/^[1-9]$/.test(key)) {
    const n = parseInt(key, 10);
    if (n <= state.size) enterValue(n);
    return;
  }

  // Clear cell
  if (key === 'Backspace' || key === 'Delete' || key === '0') {
    enterValue(0);
    return;
  }

  // Arrow-key navigation
  if (!state.selected) return;
  let { r, c } = state.selected;
  if (key === 'ArrowUp'    && r > 0)              r--;
  if (key === 'ArrowDown'  && r < state.size - 1) r++;
  if (key === 'ArrowLeft'  && c > 0)              c--;
  if (key === 'ArrowRight' && c < state.size - 1) c++;
  selectCell(r, c);
});

/* ═══════════════════════════════════════════════════════════════
   BUTTON WIRING
═══════════════════════════════════════════════════════════════ */
$('btn-check').addEventListener('click', checkSolution);
$('btn-solve').addEventListener('click', revealSolution);
$('btn-new').addEventListener('click', newGame);
$('difficulty').addEventListener('change', newGame);

// Responsive re-render on window resize
window.addEventListener('resize', () => { if (state.puzzle) renderGrid(); });

/* ═══════════════════════════════════════════════════════════════
   BOOT
═══════════════════════════════════════════════════════════════ */
newGame();
