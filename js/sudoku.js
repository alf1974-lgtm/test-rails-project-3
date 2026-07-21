/**
 * sudoku.js — Full Sudoku game logic
 *
 * Features:
 *  • Puzzle generation via backtracking solver + controlled cell removal
 *  • Three difficulty levels (easy / medium / hard)
 *  • Cell selection, keyboard & numpad input
 *  • Real-time conflict highlighting
 *  • Hint (reveals one random empty cell)
 *  • Check (marks all incorrect user entries)
 *  • Solve (fills the board with the solution)
 *  • Timer
 *  • Win detection + modal
 */

'use strict';

/* ── Constants ──────────────────────────────────────────────────────── */
const DIFFICULTY_CLUES = { easy: 46, medium: 32, hard: 24 };

/* ── State ──────────────────────────────────────────────────────────── */
let puzzle   = [];   // 81-element array, 0 = empty
let solution = [];   // 81-element array, fully solved
let given    = [];   // bool[81] — true if the cell was pre-filled
let hinted   = [];   // bool[81] — true if revealed by hint
let selected = -1;   // index of currently selected cell (0-78) or -1

let timerInterval = null;
let secondsElapsed = 0;
let gameActive = false;

/* ── DOM refs ───────────────────────────────────────────────────────── */
const boardEl      = document.getElementById('sudoku-board');
const timerEl      = document.getElementById('timer');
const messageBar   = document.getElementById('message-bar');
const winModal     = document.getElementById('win-modal');
const modalTimeEl  = document.getElementById('modal-time');
const difficultyEl = document.getElementById('difficulty');

/* ── Utility helpers ────────────────────────────────────────────────── */
const idx  = (r, c) => r * 9 + c;
const row  = i => Math.floor(i / 9);
const col  = i => i % 9;
const box  = i => Math.floor(row(i) / 3) * 3 + Math.floor(col(i) / 3);

function shuffle(arr) {
  for (let i = arr.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [arr[i], arr[j]] = [arr[j], arr[i]];
  }
  return arr;
}

function cloneGrid(g) { return g.slice(); }

/* ── Solver (backtracking) ──────────────────────────────────────────── */
/**
 * Fills `grid` in-place. Returns true if a solution was found.
 * When `randomise` is true the digit order is shuffled (for generation).
 */
function solve(grid, randomise = false) {
  const empty = grid.indexOf(0);
  if (empty === -1) return true;          // all cells filled → solved

  const r = row(empty), c = col(empty);
  const digits = randomise ? shuffle([1,2,3,4,5,6,7,8,9]) : [1,2,3,4,5,6,7,8,9];

  for (const d of digits) {
    if (isValid(grid, r, c, d)) {
      grid[empty] = d;
      if (solve(grid, randomise)) return true;
      grid[empty] = 0;
    }
  }
  return false;
}

/**
 * Count solutions up to `limit` (used to ensure unique puzzles).
 */
function countSolutions(grid, limit = 2) {
  const empty = grid.indexOf(0);
  if (empty === -1) return 1;

  let count = 0;
  const r = row(empty), c = col(empty);
  for (let d = 1; d <= 9; d++) {
    if (isValid(grid, r, c, d)) {
      grid[empty] = d;
      count += countSolutions(grid, limit);
      grid[empty] = 0;
      if (count >= limit) break;
    }
  }
  return count;
}

function isValid(grid, r, c, d) {
  for (let k = 0; k < 9; k++) {
    if (grid[idx(r, k)] === d) return false;   // row
    if (grid[idx(k, c)] === d) return false;   // col
    const br = Math.floor(r / 3) * 3 + Math.floor(k / 3);
    const bc = Math.floor(c / 3) * 3 + (k % 3);
    if (grid[idx(br, bc)] === d) return false; // box
  }
  return true;
}

/* ── Puzzle generation ──────────────────────────────────────────────── */
function generatePuzzle(difficulty) {
  // 1. Start with an empty grid and fill it randomly → full solution
  const full = new Array(81).fill(0);
  solve(full, true);

  // 2. Remove cells while keeping a unique solution
  const clues = DIFFICULTY_CLUES[difficulty] || 32;
  const toRemove = 81 - clues;
  const positions = shuffle([...Array(81).keys()]);

  const puzzle = cloneGrid(full);
  let removed = 0;

  for (const pos of positions) {
    if (removed >= toRemove) break;
    const backup = puzzle[pos];
    puzzle[pos] = 0;
    // Verify uniqueness (only for medium/hard to keep generation fast)
    if (difficulty === 'easy' || countSolutions(cloneGrid(puzzle)) === 1) {
      removed++;
    } else {
      puzzle[pos] = backup;
    }
  }

  return { puzzle, solution: full };
}

/* ── Timer ──────────────────────────────────────────────────────────── */
function startTimer() {
  stopTimer();
  secondsElapsed = 0;
  updateTimerDisplay();
  timerInterval = setInterval(() => {
    secondsElapsed++;
    updateTimerDisplay();
  }, 1000);
}

function stopTimer() {
  clearInterval(timerInterval);
  timerInterval = null;
}

function updateTimerDisplay() {
  const m = String(Math.floor(secondsElapsed / 60)).padStart(2, '0');
  const s = String(secondsElapsed % 60).padStart(2, '0');
  timerEl.textContent = `${m}:${s}`;
}

function formatTime(secs) {
  const m = Math.floor(secs / 60);
  const s = secs % 60;
  return m > 0 ? `${m}m ${s}s` : `${s}s`;
}

/* ── Board rendering ────────────────────────────────────────────────── */
function buildBoard() {
  boardEl.innerHTML = '';
  for (let r = 0; r < 9; r++) {
    const tr = document.createElement('tr');
    for (let c = 0; c < 9; c++) {
      const i = idx(r, c);
      const td = document.createElement('td');
      td.dataset.index = i;

      const input = document.createElement('input');
      input.type = 'text';
      input.inputMode = 'numeric';
      input.maxLength = 1;
      input.readOnly = true;          // we handle input ourselves
      input.setAttribute('aria-label', `Row ${r+1} Column ${c+1}`);

      if (given[i]) {
        td.classList.add('given');
        input.value = puzzle[i];
      }

      td.appendChild(input);
      td.addEventListener('click', () => selectCell(i));
      tr.appendChild(td);
    }
    boardEl.appendChild(tr);
  }
}

function cellEl(i) {
  return boardEl.querySelector(`td[data-index="${i}"]`);
}

function inputEl(i) {
  const td = cellEl(i);
  return td ? td.querySelector('input') : null;
}

/* ── Cell selection & highlighting ─────────────────────────────────── */
function selectCell(i) {
  if (!gameActive) return;
  selected = i;
  refreshHighlights();
}

function refreshHighlights() {
  const cells = boardEl.querySelectorAll('td');
  cells.forEach(td => {
    td.classList.remove('selected', 'peer', 'same-num');
  });

  if (selected === -1) return;

  const selVal = puzzle[selected];
  const selRow = row(selected);
  const selCol = col(selected);
  const selBox = box(selected);

  cells.forEach(td => {
    const i = parseInt(td.dataset.index, 10);
    if (i === selected) {
      td.classList.add('selected');
      return;
    }
    const isPeer = row(i) === selRow || col(i) === selCol || box(i) === selBox;
    if (isPeer) td.classList.add('peer');
    if (selVal !== 0 && puzzle[i] === selVal) td.classList.add('same-num');
  });
}

/* ── Input handling ─────────────────────────────────────────────────── */
function enterDigit(d) {
  if (!gameActive || selected === -1) return;
  if (given[selected]) return;

  clearMessage();
  const td = cellEl(selected);
  const inp = inputEl(selected);

  td.classList.remove('error', 'hint-cell');
  hinted[selected] = false;

  if (d === 0) {
    puzzle[selected] = 0;
    inp.value = '';
  } else {
    puzzle[selected] = d;
    inp.value = d;
  }

  refreshHighlights();
  checkForWin();
}

/* ── Keyboard support ───────────────────────────────────────────────── */
document.addEventListener('keydown', e => {
  if (!gameActive) return;

  if (e.key >= '1' && e.key <= '9') {
    enterDigit(parseInt(e.key, 10));
    return;
  }
  if (e.key === '0' || e.key === 'Backspace' || e.key === 'Delete') {
    enterDigit(0);
    return;
  }

  // Arrow-key navigation
  if (selected === -1) { selectCell(0); return; }
  const r = row(selected), c = col(selected);
  const moves = { ArrowUp: [-1,0], ArrowDown: [1,0], ArrowLeft: [0,-1], ArrowRight: [0,1] };
  if (moves[e.key]) {
    e.preventDefault();
    const [dr, dc] = moves[e.key];
    const nr = (r + dr + 9) % 9;
    const nc = (c + dc + 9) % 9;
    selectCell(idx(nr, nc));
  }
});

/* ── Numpad buttons ─────────────────────────────────────────────────── */
document.getElementById('numpad').addEventListener('click', e => {
  const btn = e.target.closest('.num-btn');
  if (!btn) return;
  enterDigit(parseInt(btn.dataset.value, 10));
});

/* ── Check ──────────────────────────────────────────────────────────── */
function checkBoard() {
  if (!gameActive) return;
  let errors = 0;
  for (let i = 0; i < 81; i++) {
    if (given[i] || hinted[i]) continue;
    const td = cellEl(i);
    td.classList.remove('error');
    if (puzzle[i] !== 0 && puzzle[i] !== solution[i]) {
      td.classList.add('error');
      errors++;
    }
  }
  if (errors === 0) {
    showMessage('No mistakes found! Keep going.', 'success');
  } else {
    showMessage(`${errors} incorrect cell${errors > 1 ? 's' : ''} highlighted in red.`, 'error');
  }
}

/* ── Hint ───────────────────────────────────────────────────────────── */
function giveHint() {
  if (!gameActive) return;
  const empties = [];
  for (let i = 0; i < 81; i++) {
    if (!given[i] && puzzle[i] !== solution[i]) empties.push(i);
  }
  if (empties.length === 0) { showMessage('The board is already complete!', 'info'); return; }

  const i = empties[Math.floor(Math.random() * empties.length)];
  puzzle[i] = solution[i];
  hinted[i] = true;

  const td  = cellEl(i);
  const inp = inputEl(i);
  td.classList.remove('error');
  td.classList.add('hint-cell');
  inp.value = solution[i];

  refreshHighlights();
  showMessage('Hint applied!', 'info');
  checkForWin();
}

/* ── Solve ──────────────────────────────────────────────────────────── */
function solveBoard() {
  if (!gameActive) return;
  stopTimer();
  gameActive = false;

  for (let i = 0; i < 81; i++) {
    puzzle[i] = solution[i];
    const td  = cellEl(i);
    const inp = inputEl(i);
    td.classList.remove('error', 'hint-cell', 'selected', 'peer', 'same-num');
    inp.value = solution[i];
  }
  showMessage('Board solved. Start a new game to play again!', 'info');
}

/* ── Win detection ──────────────────────────────────────────────────── */
function checkForWin() {
  for (let i = 0; i < 81; i++) {
    if (puzzle[i] !== solution[i]) return;
  }
  // All cells match the solution
  stopTimer();
  gameActive = false;
  selected = -1;
  refreshHighlights();

  modalTimeEl.textContent = `Completed in ${formatTime(secondsElapsed)}`;
  winModal.classList.remove('hidden');
}

/* ── New game ───────────────────────────────────────────────────────── */
function newGame() {
  winModal.classList.add('hidden');
  clearMessage();
  stopTimer();

  const difficulty = difficultyEl.value;
  const result = generatePuzzle(difficulty);
  puzzle   = result.puzzle;
  solution = result.solution;
  given    = puzzle.map(v => v !== 0);
  hinted   = new Array(81).fill(false);
  selected = -1;
  gameActive = true;

  buildBoard();
  startTimer();
}

/* ── Message bar ────────────────────────────────────────────────────── */
let msgTimeout = null;
function showMessage(text, type = 'info') {
  clearTimeout(msgTimeout);
  messageBar.textContent = text;
  messageBar.className = `message-bar ${type}`;
  msgTimeout = setTimeout(clearMessage, 4000);
}

function clearMessage() {
  messageBar.className = 'message-bar hidden';
  messageBar.textContent = '';
}

/* ── Button wiring ──────────────────────────────────────────────────── */
document.getElementById('btn-new').addEventListener('click', newGame);
document.getElementById('btn-hint').addEventListener('click', giveHint);
document.getElementById('btn-check').addEventListener('click', checkBoard);
document.getElementById('btn-solve').addEventListener('click', solveBoard);
document.getElementById('modal-new-btn').addEventListener('click', newGame);

/* ── Kick off ───────────────────────────────────────────────────────── */
newGame();
