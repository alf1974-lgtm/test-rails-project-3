/**
 * Tic Tac Toe — two players, same browser
 * Player 1 = X  |  Player 2 = O
 */

(function () {
  'use strict';

  // ── Winning combinations (indices into the 9-cell board) ──
  const WIN_COMBOS = [
    [0, 1, 2], // top row
    [3, 4, 5], // middle row
    [6, 7, 8], // bottom row
    [0, 3, 6], // left col
    [1, 4, 7], // middle col
    [2, 5, 8], // right col
    [0, 4, 8], // diagonal ↘
    [2, 4, 6], // diagonal ↙
  ];

  // ── State ──────────────────────────────────────────────────
  let board        = Array(9).fill(null); // null | 'X' | 'O'
  let currentMark  = 'X';                 // whose turn it is
  let gameOver     = false;
  let scores       = { X: 0, O: 0, draw: 0 };

  // ── DOM refs ───────────────────────────────────────────────
  const cells          = document.querySelectorAll('.cell');
  const playerIndicator = document.getElementById('player-indicator');
  const scoreX         = document.getElementById('score-x');
  const scoreO         = document.getElementById('score-o');
  const scoreDraw      = document.getElementById('score-draw');
  const restartBtn     = document.getElementById('restart-btn');
  const resetScoresBtn = document.getElementById('reset-scores-btn');
  const overlay        = document.getElementById('overlay');
  const overlayMessage = document.getElementById('overlay-message');
  const overlayBtn     = document.getElementById('overlay-btn');

  // ── Helpers ────────────────────────────────────────────────

  /** Update the turn indicator text + colour class */
  function updateIndicator () {
    const isX = currentMark === 'X';
    playerIndicator.textContent = isX
      ? "Player 1's turn (X)"
      : "Player 2's turn (O)";
    playerIndicator.className = isX ? 'player-x' : 'player-o';
  }

  /** Check whether `mark` has won; returns winning indices or null */
  function checkWin (mark) {
    for (const combo of WIN_COMBOS) {
      if (combo.every(i => board[i] === mark)) return combo;
    }
    return null;
  }

  /** Highlight the three winning cells */
  function highlightWinners (combo) {
    combo.forEach(i => cells[i].classList.add('winner'));
  }

  /** Show the end-of-game overlay */
  function showOverlay (message) {
    overlayMessage.textContent = message;
    overlay.classList.remove('hidden');
  }

  /** Disable all cells (game over) */
  function lockBoard () {
    cells.forEach(cell => cell.setAttribute('disabled', ''));
  }

  /** Reset the board for a new round (scores preserved) */
  function resetBoard () {
    board       = Array(9).fill(null);
    currentMark = 'X';
    gameOver    = false;

    cells.forEach(cell => {
      cell.textContent = '';
      cell.className   = 'cell';          // strip x / o / winner classes
      cell.removeAttribute('disabled');
    });

    overlay.classList.add('hidden');
    updateIndicator();
  }

  /** Update the scoreboard display */
  function renderScores () {
    scoreX.textContent    = scores.X;
    scoreO.textContent    = scores.O;
    scoreDraw.textContent = scores.draw;
  }

  // ── Cell click handler ─────────────────────────────────────
  function handleCellClick (e) {
    const cell  = e.currentTarget;
    const index = parseInt(cell.dataset.index, 10);

    // Ignore if already filled or game is over
    if (board[index] || gameOver) return;

    // Place the mark
    board[index]     = currentMark;
    cell.textContent = currentMark;
    cell.classList.add(currentMark.toLowerCase()); // 'x' or 'o'
    cell.setAttribute('disabled', '');

    // Check for a win
    const winCombo = checkWin(currentMark);
    if (winCombo) {
      gameOver = true;
      highlightWinners(winCombo);
      lockBoard();
      scores[currentMark]++;
      renderScores();
      const winner = currentMark === 'X' ? 'Player 1 (X)' : 'Player 2 (O)';
      setTimeout(() => showOverlay(`🎉 ${winner} wins!`), 350);
      return;
    }

    // Check for a draw
    if (board.every(cell => cell !== null)) {
      gameOver = true;
      scores.draw++;
      renderScores();
      setTimeout(() => showOverlay("It's a draw! 🤝"), 350);
      return;
    }

    // Switch turns
    currentMark = currentMark === 'X' ? 'O' : 'X';
    updateIndicator();
  }

  // ── Event listeners ────────────────────────────────────────
  cells.forEach(cell => cell.addEventListener('click', handleCellClick));

  restartBtn.addEventListener('click', resetBoard);

  overlayBtn.addEventListener('click', resetBoard);

  resetScoresBtn.addEventListener('click', () => {
    scores = { X: 0, O: 0, draw: 0 };
    renderScores();
    resetBoard();
  });

  // ── Keyboard accessibility: Enter / Space on focused cell ──
  cells.forEach(cell => {
    cell.addEventListener('keydown', e => {
      if (e.key === 'Enter' || e.key === ' ') {
        e.preventDefault();
        cell.click();
      }
    });
  });

  // ── Init ───────────────────────────────────────────────────
  updateIndicator();
  renderScores();

}());
