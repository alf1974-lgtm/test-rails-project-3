/**
 * Tic Tac Toe — two-player, same browser
 *
 * Player X always goes first.  Players physically hand the mouse to each
 * other after every move.  No AI, no networking — just pure DOM fun.
 */

(function () {
  'use strict';

  // ── Constants ──────────────────────────────────────────────────────────────

  const WINNING_LINES = [
    [0, 1, 2], // top row
    [3, 4, 5], // middle row
    [6, 7, 8], // bottom row
    [0, 3, 6], // left col
    [1, 4, 7], // middle col
    [2, 5, 8], // right col
    [0, 4, 8], // diagonal ↘
    [2, 4, 6], // diagonal ↙
  ];

  // ── State ──────────────────────────────────────────────────────────────────

  let board        = Array(9).fill(null); // null | 'X' | 'O'
  let currentPlayer = 'X';
  let gameOver      = false;
  let scores        = { X: 0, O: 0, draws: 0 };

  // ── DOM refs ───────────────────────────────────────────────────────────────

  const cells      = Array.from(document.querySelectorAll('.cell'));
  const statusEl   = document.getElementById('status-text');
  const statusBar  = statusEl.closest('.status-bar');
  const winsXEl    = document.getElementById('wins-x');
  const winsOEl    = document.getElementById('wins-o');
  const drawsEl    = document.getElementById('draws');
  const scoreX     = document.getElementById('score-x');
  const scoreO     = document.getElementById('score-o');
  const btnReset   = document.getElementById('btn-reset');

  // ── Helpers ────────────────────────────────────────────────────────────────

  /**
   * Check whether `player` has won on the current board.
   * Returns the winning line (array of indices) or null.
   */
  function checkWinner(player) {
    for (const line of WINNING_LINES) {
      if (line.every(i => board[i] === player)) return line;
    }
    return null;
  }

  /** True when every cell is filled (used to detect a draw). */
  function isBoardFull() {
    return board.every(cell => cell !== null);
  }

  // ── Rendering ──────────────────────────────────────────────────────────────

  function renderStatus() {
    // Remove all state classes first
    statusBar.className = 'status-bar';

    if (!gameOver) {
      statusBar.classList.add(`turn-${currentPlayer.toLowerCase()}`);
      statusEl.innerHTML = `Player <strong>${currentPlayer}</strong>'s turn`;
    }
    // Winner / draw messages are set directly in handleCellClick after game ends
  }

  function renderScores() {
    winsXEl.textContent = scores.X;
    winsOEl.textContent = scores.O;
    drawsEl.textContent = scores.draws;
  }

  /** Highlight the active player's score card. */
  function renderActiveCard() {
    scoreX.classList.remove('active-x', 'active-o');
    scoreO.classList.remove('active-x', 'active-o');

    if (!gameOver) {
      if (currentPlayer === 'X') scoreX.classList.add('active-x');
      else                        scoreO.classList.add('active-o');
    }
  }

  // ── Core game logic ────────────────────────────────────────────────────────

  function handleCellClick(event) {
    const cell  = event.currentTarget;
    const index = parseInt(cell.dataset.index, 10);

    // Ignore clicks on filled cells or after game over
    if (board[index] !== null || gameOver) return;

    // Place the mark
    board[index] = currentPlayer;
    cell.textContent = currentPlayer;
    cell.classList.add(currentPlayer.toLowerCase());
    cell.disabled = true;

    // Check for a winner
    const winLine = checkWinner(currentPlayer);
    if (winLine) {
      gameOver = true;
      scores[currentPlayer]++;

      // Highlight winning cells
      winLine.forEach(i => cells[i].classList.add('winning'));

      // Disable all remaining cells
      cells.forEach(c => { c.disabled = true; });

      // Update status
      statusBar.className = `status-bar winner winner-${currentPlayer.toLowerCase()}`;
      statusEl.innerHTML  = `🎉 Player <strong>${currentPlayer}</strong> wins!`;

      renderScores();
      renderActiveCard();
      return;
    }

    // Check for a draw
    if (isBoardFull()) {
      gameOver = true;
      scores.draws++;

      statusBar.className = 'status-bar draw';
      statusEl.textContent = "It's a draw! 🤝";

      renderScores();
      renderActiveCard();
      return;
    }

    // Switch player and update UI
    currentPlayer = currentPlayer === 'X' ? 'O' : 'X';
    renderStatus();
    renderActiveCard();
  }

  function resetGame() {
    board         = Array(9).fill(null);
    currentPlayer = 'X';
    gameOver      = false;

    cells.forEach(cell => {
      cell.textContent = '';
      cell.className   = 'cell';   // wipes x / o / winning classes
      cell.disabled    = false;
    });

    renderStatus();
    renderActiveCard();
  }

  // ── Event listeners ────────────────────────────────────────────────────────

  cells.forEach(cell => cell.addEventListener('click', handleCellClick));
  btnReset.addEventListener('click', resetGame);

  // ── Initial render ─────────────────────────────────────────────────────────

  renderStatus();
  renderActiveCard();
  renderScores();

})();
