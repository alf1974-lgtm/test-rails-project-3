/**
 * Tic Tac Toe — two players, same browser
 * Player 1 = X  |  Player 2 = O
 */

(function () {
  'use strict';

  // ── Constants ──────────────────────────────────────────────
  const WINNING_LINES = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], // rows
    [0, 3, 6], [1, 4, 7], [2, 5, 8], // cols
    [0, 4, 8], [2, 4, 6],            // diagonals
  ];

  // ── State ──────────────────────────────────────────────────
  let board       = Array(9).fill(null); // null | 'X' | 'O'
  let currentMark = 'X';                 // whose turn
  let gameOver    = false;
  let scores      = { X: 0, O: 0, D: 0 };

  // ── DOM refs ───────────────────────────────────────────────
  const cells        = document.querySelectorAll('.cell');
  const statusEl     = document.getElementById('status');
  const scoreX       = document.getElementById('score-x');
  const scoreO       = document.getElementById('score-o');
  const scoreD       = document.getElementById('score-d');
  const btnRestart   = document.getElementById('btn-restart');
  const btnReset     = document.getElementById('btn-reset-scores');

  // ── Helpers ────────────────────────────────────────────────
  function setStatus(text, cssClass) {
    statusEl.textContent = text;
    statusEl.className   = cssClass;
  }

  function updateScoreboard() {
    scoreX.textContent = scores.X;
    scoreO.textContent = scores.O;
    scoreD.textContent = scores.D;
  }

  function checkWinner() {
    for (const [a, b, c] of WINNING_LINES) {
      if (board[a] && board[a] === board[b] && board[a] === board[c]) {
        return { winner: board[a], line: [a, b, c] };
      }
    }
    if (board.every(Boolean)) return { winner: null, line: null, draw: true };
    return null;
  }

  function highlightWinningLine(line) {
    line.forEach(idx => cells[idx].classList.add('winning'));
  }

  // ── Core: handle a cell click ──────────────────────────────
  function handleClick(idx) {
    if (gameOver || board[idx]) return;

    // Place mark
    board[idx] = currentMark;
    const cell = cells[idx];
    cell.classList.add('taken', currentMark.toLowerCase());
    cell.innerHTML = `<span>${currentMark}</span>`;

    // Check result
    const result = checkWinner();

    if (result) {
      gameOver = true;
      cells.forEach(c => c.classList.add('game-over'));

      if (result.draw) {
        scores.D++;
        setStatus("It's a draw! 🤝", 'draw');
      } else {
        scores[result.winner]++;
        highlightWinningLine(result.line);
        const playerNum = result.winner === 'X' ? 1 : 2;
        setStatus(`Player ${playerNum} (${result.winner}) wins! 🎉`, 'winner');
      }
      updateScoreboard();
      return;
    }

    // Switch turn
    currentMark = currentMark === 'X' ? 'O' : 'X';
    const nextPlayer = currentMark === 'X' ? 1 : 2;
    setStatus(`Player ${nextPlayer}'s turn  (${currentMark})`, `${currentMark.toLowerCase()}-turn`);
  }

  // ── Restart (keep scores) ──────────────────────────────────
  function restartGame() {
    board       = Array(9).fill(null);
    currentMark = 'X';
    gameOver    = false;

    cells.forEach(cell => {
      cell.className = 'cell';
      cell.innerHTML = '';
    });

    setStatus("Player 1's turn  (X)", 'x-turn');
  }

  // ── Reset scores ───────────────────────────────────────────
  function resetScores() {
    scores = { X: 0, O: 0, D: 0 };
    updateScoreboard();
    restartGame();
  }

  // ── Event listeners ────────────────────────────────────────
  cells.forEach((cell, idx) => {
    cell.addEventListener('click', () => handleClick(idx));
  });

  btnRestart.addEventListener('click', restartGame);
  btnReset.addEventListener('click', resetScores);

  // ── Init ───────────────────────────────────────────────────
  setStatus("Player 1's turn  (X)", 'x-turn');
  updateScoreboard();

}());
