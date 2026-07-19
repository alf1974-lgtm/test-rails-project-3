/**
 * Tic Tac Toe – two players, same browser
 * Player 1 = X  |  Player 2 = O
 */

(() => {
  'use strict';

  // ── Constants ──────────────────────────────────────────────
  const WINNING_LINES = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], // rows
    [0, 3, 6], [1, 4, 7], [2, 5, 8], // cols
    [0, 4, 8], [2, 4, 6],             // diagonals
  ];

  // ── State ──────────────────────────────────────────────────
  let board        = Array(9).fill(null); // null | 'X' | 'O'
  let currentPlayer = 'X';
  let gameOver      = false;
  let scores        = { X: 0, O: 0, draw: 0 };

  // ── DOM refs ───────────────────────────────────────────────
  const cells         = document.querySelectorAll('.cell');
  const statusEl      = document.getElementById('status');
  const scoreX        = document.getElementById('score-x');
  const scoreO        = document.getElementById('score-o');
  const scoreDraw     = document.getElementById('score-draw');
  const btnRestart    = document.getElementById('btn-restart');
  const btnResetScores= document.getElementById('btn-reset-scores');

  // ── Helpers ────────────────────────────────────────────────
  function setStatus(text, cssClass) {
    statusEl.textContent = text;
    statusEl.className   = cssClass;
  }

  function updateScoreboard() {
    scoreX.textContent    = scores.X;
    scoreO.textContent    = scores.O;
    scoreDraw.textContent = scores.draw;
  }

  function checkWinner() {
    for (const [a, b, c] of WINNING_LINES) {
      if (board[a] && board[a] === board[b] && board[a] === board[c]) {
        return { winner: board[a], line: [a, b, c] };
      }
    }
    if (board.every(cell => cell !== null)) return { winner: null, line: [] }; // draw
    return null; // game continues
  }

  function highlightWinningLine(line) {
    line.forEach(idx => cells[idx].classList.add('win'));
  }

  // ── Core game logic ────────────────────────────────────────
  function handleCellClick(idx) {
    if (gameOver || board[idx]) return;

    // Place mark
    board[idx] = currentPlayer;
    const cell = cells[idx];
    cell.classList.add('taken', currentPlayer.toLowerCase());
    cell.innerHTML = `<span>${currentPlayer}</span>`;

    // Check result
    const result = checkWinner();

    if (result) {
      gameOver = true;
      if (result.winner) {
        highlightWinningLine(result.line);
        scores[result.winner]++;
        updateScoreboard();
        const playerNum = result.winner === 'X' ? 1 : 2;
        setStatus(`🎉 Player ${playerNum} (${result.winner}) wins!`, 'winner');
      } else {
        scores.draw++;
        updateScoreboard();
        setStatus("It's a draw!", 'draw');
      }
      return;
    }

    // Switch player
    currentPlayer = currentPlayer === 'X' ? 'O' : 'X';
    const nextNum = currentPlayer === 'X' ? 1 : 2;
    setStatus(`Player ${nextNum}'s turn  (${currentPlayer})`, `${currentPlayer.toLowerCase()}-turn`);
  }

  function restartGame() {
    board         = Array(9).fill(null);
    currentPlayer = 'X';
    gameOver      = false;

    cells.forEach(cell => {
      cell.className = 'cell';
      cell.innerHTML = '';
    });

    setStatus("Player 1's turn  (X)", 'x-turn');
  }

  function resetScores() {
    scores = { X: 0, O: 0, draw: 0 };
    updateScoreboard();
    restartGame();
  }

  // ── Event listeners ────────────────────────────────────────
  cells.forEach((cell, idx) => {
    cell.addEventListener('click', () => handleCellClick(idx));
  });

  btnRestart.addEventListener('click', restartGame);
  btnResetScores.addEventListener('click', resetScores);

  // ── Init ───────────────────────────────────────────────────
  setStatus("Player 1's turn  (X)", 'x-turn');
  updateScoreboard();
})();
