/**
 * KenKen Puzzle — kenken.js
 *
 * Self-contained implementation:
 *  • Latin-square generation (Fisher-Yates shuffle + backtracking)
 *  • Cage generation with configurable difficulty
 *  • Constraint-based solver (used for validation & "Solve" button)
 *  • Full interactive UI (keyboard + numpad, highlighting, timer, confetti)
 */

'use strict';

/* ═══════════════════════════════════════════════════════════
   1.  UTILITIES
═══════════════════════════════════════════════════════════ */

function shuffle(arr) {
  for (let i = arr.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [arr[i], arr[j]] = [arr[j], arr[i]];
  }
  return arr;
}

function range(n) { return Array.from({ length: n }, (_, i) => i + 1); }

function cloneGrid(g) { return g.map(r => r.slice()); }

/* ═══════════════════════════════════════════════════════════
   2.  LATIN-SQUARE GENERATOR
═══════════════════════════════════════════════════════════ */

function generateLatinSquare(n) {
  const grid = Array.from({ length: n }, () => Array(n).fill(0));

  function isValid(r, c, v) {
    for (let i = 0; i < n; i++) {
      if (grid[r][i] === v || grid[i][c] === v) return false;
    }
    return true;
  }

  function solve(pos) {
    if (pos === n * n) return true;
    const r = Math.floor(pos / n);
    const c = pos % n;
    const digits = shuffle(range(n));
    for (const v of digits) {
      if (isValid(r, c, v)) {
        grid[r][c] = v;
        if (solve(pos + 1)) return true;
        grid[r][c] = 0;
      }
    }
    return false;
  }

  solve(0);
  return grid;
}

/* ═══════════════════════════════════════════════════════════
   3.  CAGE GENERATOR
═══════════════════════════════════════════════════════════ */

/**
 * Difficulty controls:
 *  easy   – more single-cell & addition cages, smaller cages
 *  medium – mix of all operations, medium cage sizes
 *  hard   – larger cages, subtraction/division preferred
 */
const DIFFICULTY = {
  easy:   { maxCageSize: 2, singleCellProb: 0.20, preferAdd: true  },
  medium: { maxCageSize: 4, singleCellProb: 0.10, preferAdd: false },
  hard:   { maxCageSize: 5, singleCellProb: 0.05, preferAdd: false },
};

function generateCages(grid, n, difficulty) {
  const cfg = DIFFICULTY[difficulty] || DIFFICULTY.medium;
  const assigned = Array.from({ length: n }, () => Array(n).fill(false));
  const cages = [];

  // BFS flood-fill to build a cage starting at (r,c)
  function buildCage(startR, startC) {
    const maxSize = cfg.maxCageSize;
    // Single-cell with some probability
    if (Math.random() < cfg.singleCellProb) {
      return [{ r: startR, c: startC }];
    }
    const cells = [{ r: startR, c: startC }];
    const size = 1 + Math.floor(Math.random() * (maxSize - 1));
    const dirs = shuffle([[-1,0],[1,0],[0,-1],[0,1]]);

    while (cells.length < size) {
      let added = false;
      for (const { r, c } of shuffle(cells.slice())) {
        for (const [dr, dc] of shuffle(dirs.slice())) {
          const nr = r + dr, nc = c + dc;
          if (nr >= 0 && nr < n && nc >= 0 && nc < n && !assigned[nr][nc]) {
            cells.push({ r: nr, c: nc });
            added = true;
            break;
          }
        }
        if (added) break;
      }
      if (!added) break;
    }
    return cells;
  }

  // Choose operation and compute target for a cage
  function cageOp(cells) {
    const vals = cells.map(({ r, c }) => grid[r][c]);

    if (cells.length === 1) {
      return { op: '', target: vals[0] };
    }

    if (cells.length === 2) {
      const [a, b] = vals.sort((x, y) => y - x); // descending
      const ops = [];

      // Addition always valid
      ops.push({ op: '+', target: a + b });

      // Subtraction
      ops.push({ op: '−', target: a - b });

      // Multiplication
      ops.push({ op: '×', target: a * b });

      // Division (only if exact)
      if (a % b === 0) ops.push({ op: '÷', target: a / b });

      // Difficulty weighting
      if (cfg.preferAdd) {
        return ops[0]; // always addition for easy
      }
      return ops[Math.floor(Math.random() * ops.length)];
    }

    // 3+ cells: addition or multiplication
    const sum  = vals.reduce((s, v) => s + v, 0);
    const prod = vals.reduce((p, v) => p * v, 1);

    if (cfg.preferAdd || Math.random() < 0.5) {
      return { op: '+', target: sum };
    }
    return { op: '×', target: prod };
  }

  // Iterate over every cell in reading order
  for (let r = 0; r < n; r++) {
    for (let c = 0; c < n; c++) {
      if (assigned[r][c]) continue;
      const cells = buildCage(r, c);
      cells.forEach(cell => { assigned[cell.r][cell.c] = true; });
      const { op, target } = cageOp(cells);
      cages.push({ cells, op, target });
    }
  }

  return cages;
}

/* ═══════════════════════════════════════════════════════════
   4.  CONSTRAINT SOLVER  (backtracking + forward checking)
═══════════════════════════════════════════════════════════ */

function solvePuzzle(n, cages) {
  const grid = Array.from({ length: n }, () => Array(n).fill(0));

  // Map cell → cage index
  const cellCage = Array.from({ length: n }, () => Array(n).fill(-1));
  cages.forEach((cage, idx) => {
    cage.cells.forEach(({ r, c }) => { cellCage[r][c] = idx; });
  });

  function rowOk(r, v) {
    return !grid[r].includes(v);
  }
  function colOk(c, v) {
    return grid.every(row => row[c] !== v);
  }

  // Check if a cage is still satisfiable given current partial fill
  function cageOk(cageIdx) {
    const cage = cages[cageIdx];
    const vals = cage.cells.map(({ r, c }) => grid[r][c]);
    const filled = vals.filter(v => v !== 0);
    const empty  = vals.length - filled.length;

    if (empty === 0) {
      // All filled — verify exactly
      return checkCage(cage, vals);
    }

    // Partial — optimistic check
    const { op, target } = cage;
    if (op === '+') {
      const s = filled.reduce((a, b) => a + b, 0);
      return s < target; // still room to grow
    }
    if (op === '×') {
      const p = filled.reduce((a, b) => a * b, 1);
      return p <= target && target % p === 0;
    }
    // For − and ÷ we only check when complete
    return true;
  }

  function checkCage(cage, vals) {
    const { op, target } = cage;
    if (op === '') return vals[0] === target;
    if (op === '+') return vals.reduce((a, b) => a + b, 0) === target;
    if (op === '×') return vals.reduce((a, b) => a * b, 1) === target;
    if (op === '−') {
      const sorted = vals.slice().sort((a, b) => b - a);
      return sorted[0] - sorted[1] === target;
    }
    if (op === '÷') {
      const sorted = vals.slice().sort((a, b) => b - a);
      return sorted[0] / sorted[1] === target;
    }
    return false;
  }

  function bt(pos) {
    if (pos === n * n) return true;
    const r = Math.floor(pos / n);
    const c = pos % n;

    for (let v = 1; v <= n; v++) {
      if (!rowOk(r, v) || !colOk(c, v)) continue;
      grid[r][c] = v;
      const ci = cellCage[r][c];
      if (ci !== -1 && !cageOk(ci)) { grid[r][c] = 0; continue; }
      if (bt(pos + 1)) return true;
      grid[r][c] = 0;
    }
    return false;
  }

  return bt(0) ? grid : null;
}

/* ═══════════════════════════════════════════════════════════
   5.  GAME STATE
═══════════════════════════════════════════════════════════ */

let state = {
  n: 6,
  difficulty: 'medium',
  solution: null,   // 2-D array
  cages: [],
  userGrid: null,   // 2-D array (0 = empty)
  selectedCell: null,
  timerInterval: null,
  seconds: 0,
  solved: false,
};

/* ═══════════════════════════════════════════════════════════
   6.  UI HELPERS
═══════════════════════════════════════════════════════════ */

function $(id) { return document.getElementById(id); }

function setStatus(msg, cls) {
  const el = $('status-msg');
  el.textContent = msg;
  el.className = cls || '';
}

function formatTime(s) {
  const m = Math.floor(s / 60).toString().padStart(2, '0');
  const sec = (s % 60).toString().padStart(2, '0');
  return `${m}:${sec}`;
}

function startTimer() {
  stopTimer();
  state.seconds = 0;
  $('timer').textContent = '00:00';
  state.timerInterval = setInterval(() => {
    state.seconds++;
    $('timer').textContent = formatTime(state.seconds);
  }, 1000);
}

function stopTimer() {
  if (state.timerInterval) {
    clearInterval(state.timerInterval);
    state.timerInterval = null;
  }
}

/* ═══════════════════════════════════════════════════════════
   7.  BOARD RENDERING
═══════════════════════════════════════════════════════════ */

function buildBoard() {
  const { n, cages, userGrid } = state;
  const board = $('board');
  board.innerHTML = '';
  board.style.gridTemplateColumns = `repeat(${n}, var(--cell-size))`;

  // Map each cell to its cage index
  const cellCageMap = Array.from({ length: n }, () => Array(n).fill(-1));
  cages.forEach((cage, idx) => {
    cage.cells.forEach(({ r, c }) => { cellCageMap[r][c] = idx; });
  });

  // Determine cage borders for each cell
  // A border exists on a side if the neighbour belongs to a different cage
  function hasBorder(r, c, dr, dc) {
    const nr = r + dr, nc = c + dc;
    if (nr < 0 || nr >= n || nc < 0 || nc >= n) return true; // outer edge handled by board border
    return cellCageMap[r][c] !== cellCageMap[nr][nc];
  }

  for (let r = 0; r < n; r++) {
    for (let c = 0; c < n; c++) {
      const cell = document.createElement('div');
      cell.className = 'cell';
      cell.dataset.r = r;
      cell.dataset.c = c;

      if (c === n - 1) cell.classList.add('last-col');
      if (r === n - 1) cell.classList.add('last-row');

      // Cage borders
      if (hasBorder(r, c, -1,  0)) cell.classList.add('cage-top');
      if (hasBorder(r, c,  1,  0)) cell.classList.add('cage-bottom');
      if (hasBorder(r, c,  0, -1)) cell.classList.add('cage-left');
      if (hasBorder(r, c,  0,  1)) cell.classList.add('cage-right');

      // Cage label (top-left cell of each cage)
      const cageIdx = cellCageMap[r][c];
      const cage = cages[cageIdx];
      // Find the top-left cell of this cage
      const topLeft = cage.cells.reduce((best, cell) => {
        if (cell.r < best.r || (cell.r === best.r && cell.c < best.c)) return cell;
        return best;
      }, cage.cells[0]);

      if (topLeft.r === r && topLeft.c === c) {
        const label = document.createElement('span');
        label.className = 'cage-label';
        label.textContent = cage.target + (cage.op ? cage.op : '');
        cell.appendChild(label);
      }

      // User value
      const val = userGrid[r][c];
      if (val !== 0) {
        const span = document.createElement('span');
        span.className = 'cell-value';
        span.textContent = val;
        cell.appendChild(span);
      }

      cell.addEventListener('click', () => selectCell(r, c));
      board.appendChild(cell);
    }
  }

  // Rebuild numpad
  buildNumpad(n);
}

function buildNumpad(n) {
  const pad = $('numpad');
  pad.innerHTML = '';
  for (let v = 1; v <= n; v++) {
    const btn = document.createElement('button');
    btn.className = 'numpad-btn';
    btn.textContent = v;
    btn.addEventListener('click', () => enterValue(v));
    pad.appendChild(btn);
  }
  const erase = document.createElement('button');
  erase.className = 'numpad-btn erase';
  erase.textContent = '⌫ Erase';
  erase.addEventListener('click', () => enterValue(0));
  pad.appendChild(erase);
}

/* ═══════════════════════════════════════════════════════════
   8.  CELL SELECTION & HIGHLIGHTING
═══════════════════════════════════════════════════════════ */

function selectCell(r, c) {
  state.selectedCell = { r, c };
  clearHighlights();
  highlightRelated(r, c);
  const cell = getCellEl(r, c);
  if (cell) cell.classList.add('selected');
}

function getCellEl(r, c) {
  return document.querySelector(`.cell[data-r="${r}"][data-c="${c}"]`);
}

function clearHighlights() {
  document.querySelectorAll('.cell').forEach(el => {
    el.classList.remove('selected', 'highlight', 'cage-highlight', 'error', 'correct');
  });
}

function highlightRelated(r, c) {
  const { n, cages } = state;

  // Find cage of selected cell
  const cage = cages.find(cg => cg.cells.some(cell => cell.r === r && cell.c === c));

  for (let i = 0; i < n; i++) {
    // Same row
    const rowEl = getCellEl(r, i);
    if (rowEl && i !== c) rowEl.classList.add('highlight');
    // Same col
    const colEl = getCellEl(i, c);
    if (colEl && i !== r) colEl.classList.add('highlight');
  }

  // Same cage
  if (cage) {
    cage.cells.forEach(cell => {
      if (cell.r === r && cell.c === c) return;
      const el = getCellEl(cell.r, cell.c);
      if (el) el.classList.add('cage-highlight');
    });
  }
}

/* ═══════════════════════════════════════════════════════════
   9.  VALUE ENTRY
═══════════════════════════════════════════════════════════ */

function enterValue(v) {
  if (state.solved) return;
  const sel = state.selectedCell;
  if (!sel) return;
  const { r, c } = sel;

  state.userGrid[r][c] = v;
  refreshCell(r, c);
  setStatus('');

  // Re-apply highlights
  clearHighlights();
  highlightRelated(r, c);
  getCellEl(r, c).classList.add('selected');

  // Auto-check completion
  if (isBoardFull()) {
    checkSolution(true);
  }
}

function refreshCell(r, c) {
  const el = getCellEl(r, c);
  if (!el) return;
  // Remove old value span
  const old = el.querySelector('.cell-value');
  if (old) old.remove();
  const v = state.userGrid[r][c];
  if (v !== 0) {
    const span = document.createElement('span');
    span.className = 'cell-value';
    span.textContent = v;
    el.appendChild(span);
  }
}

function isBoardFull() {
  return state.userGrid.every(row => row.every(v => v !== 0));
}

/* ═══════════════════════════════════════════════════════════
   10. CHECK / SOLVE / CLEAR
═══════════════════════════════════════════════════════════ */

function checkSolution(autoCheck = false) {
  const { n, solution, userGrid, cages } = state;
  let allCorrect = true;
  let anyFilled  = false;

  // Clear previous check colours
  document.querySelectorAll('.cell').forEach(el => {
    el.classList.remove('error', 'correct');
  });

  // Check each cell against solution
  for (let r = 0; r < n; r++) {
    for (let c = 0; c < n; c++) {
      const v = userGrid[r][c];
      if (v === 0) { allCorrect = false; continue; }
      anyFilled = true;
      const el = getCellEl(r, c);
      if (v === solution[r][c]) {
        el.classList.add('correct');
      } else {
        el.classList.add('error');
        allCorrect = false;
      }
    }
  }

  if (allCorrect && isBoardFull()) {
    stopTimer();
    state.solved = true;
    setStatus(`🎉 Solved in ${formatTime(state.seconds)}!`, 'ok');
    launchConfetti();
  } else if (!autoCheck) {
    if (!anyFilled) {
      setStatus('Nothing entered yet.', 'info');
    } else {
      setStatus('Some cells are incorrect.', 'error');
    }
  }
}

function revealSolution() {
  const { n, solution } = state;
  for (let r = 0; r < n; r++) {
    for (let c = 0; c < n; c++) {
      state.userGrid[r][c] = solution[r][c];
    }
  }
  buildBoard();
  // Mark all as given
  document.querySelectorAll('.cell').forEach(el => el.classList.add('given'));
  stopTimer();
  state.solved = true;
  setStatus('Solution revealed.', 'info');
}

function clearBoard() {
  const { n } = state;
  state.userGrid = Array.from({ length: n }, () => Array(n).fill(0));
  state.solved = false;
  buildBoard();
  setStatus('');
  startTimer();
}

/* ═══════════════════════════════════════════════════════════
   11. NEW GAME
═══════════════════════════════════════════════════════════ */

function newGame() {
  const n = parseInt($('size-select').value, 10);
  const difficulty = $('difficulty-select').value;

  state.n = n;
  state.difficulty = difficulty;
  state.solved = false;
  state.selectedCell = null;

  // Update labels
  $('size-label').textContent = n;
  document.querySelectorAll('.size-ref').forEach(el => { el.textContent = n; });

  // Generate latin square
  const solution = generateLatinSquare(n);
  state.solution = solution;

  // Generate cages
  const cages = generateCages(solution, n, difficulty);
  state.cages = cages;

  // Empty user grid
  state.userGrid = Array.from({ length: n }, () => Array(n).fill(0));

  buildBoard();
  setStatus('');
  startTimer();
}

/* ═══════════════════════════════════════════════════════════
   12. KEYBOARD INPUT
═══════════════════════════════════════════════════════════ */

document.addEventListener('keydown', e => {
  if (state.solved) return;
  const sel = state.selectedCell;
  const { n } = state;

  // Arrow key navigation
  if (sel && ['ArrowUp','ArrowDown','ArrowLeft','ArrowRight'].includes(e.key)) {
    e.preventDefault();
    let { r, c } = sel;
    if (e.key === 'ArrowUp')    r = Math.max(0, r - 1);
    if (e.key === 'ArrowDown')  r = Math.min(n - 1, r + 1);
    if (e.key === 'ArrowLeft')  c = Math.max(0, c - 1);
    if (e.key === 'ArrowRight') c = Math.min(n - 1, c + 1);
    selectCell(r, c);
    return;
  }

  // Digit entry
  if (sel) {
    const digit = parseInt(e.key, 10);
    if (!isNaN(digit) && digit >= 1 && digit <= n) {
      enterValue(digit);
    } else if (e.key === 'Backspace' || e.key === 'Delete' || e.key === '0') {
      enterValue(0);
    }
  }
});

/* ═══════════════════════════════════════════════════════════
   13. CONFETTI  (lightweight canvas animation)
═══════════════════════════════════════════════════════════ */

function launchConfetti() {
  // Remove any existing canvas
  const old = $('confetti-canvas');
  if (old) old.remove();

  const canvas = document.createElement('canvas');
  canvas.id = 'confetti-canvas';
  document.body.appendChild(canvas);
  const ctx = canvas.getContext('2d');

  canvas.width  = window.innerWidth;
  canvas.height = window.innerHeight;

  const COLORS = ['#4f46e5','#06b6d4','#f59e0b','#22c55e','#ef4444','#ec4899'];
  const pieces = Array.from({ length: 160 }, () => ({
    x:  Math.random() * canvas.width,
    y:  Math.random() * -canvas.height,
    w:  6 + Math.random() * 8,
    h:  10 + Math.random() * 6,
    color: COLORS[Math.floor(Math.random() * COLORS.length)],
    rot: Math.random() * Math.PI * 2,
    vx: (Math.random() - 0.5) * 2,
    vy: 2 + Math.random() * 4,
    vr: (Math.random() - 0.5) * 0.15,
  }));

  let frame = 0;
  function draw() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    pieces.forEach(p => {
      ctx.save();
      ctx.translate(p.x, p.y);
      ctx.rotate(p.rot);
      ctx.fillStyle = p.color;
      ctx.fillRect(-p.w / 2, -p.h / 2, p.w, p.h);
      ctx.restore();
      p.x  += p.vx;
      p.y  += p.vy;
      p.rot += p.vr;
      if (p.y > canvas.height + 20) {
        p.y = -20;
        p.x = Math.random() * canvas.width;
      }
    });
    frame++;
    if (frame < 300) {
      requestAnimationFrame(draw);
    } else {
      canvas.remove();
    }
  }
  draw();
}

/* ═══════════════════════════════════════════════════════════
   14. WIRE UP BUTTONS & BOOT
═══════════════════════════════════════════════════════════ */

$('new-game-btn').addEventListener('click', newGame);
$('check-btn').addEventListener('click', () => checkSolution(false));
$('solve-btn').addEventListener('click', revealSolution);
$('clear-btn').addEventListener('click', clearBoard);

// Start immediately
newGame();
