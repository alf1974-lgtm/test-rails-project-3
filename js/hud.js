/**
 * hud.js
 * All DOM read/write for the heads-up display:
 *   - score / level / lines counters
 *   - typed-word display and feedback line
 *   - word-history list
 *   - overlay (start screen / game-over screen)
 */

// ── Score / level / lines ──────────────────────────────────────────

/**
 * Refresh the three numeric counters in the left panel.
 * @param {number} score
 * @param {number} level
 * @param {number} lines
 */
export function updateHUD(score, level, lines) {
  document.getElementById('score-display').textContent = score.toLocaleString();
  document.getElementById('level-display').textContent = level;
  document.getElementById('lines-display').textContent = lines;
}

// ── Word display ───────────────────────────────────────────────────

/**
 * Show the current typed word (or a placeholder underscore when empty).
 * @param {string} word
 */
export function updateWordDisplay(word) {
  document.getElementById('word-display').textContent =
    word.length > 0 ? word.toUpperCase() : '_';
}

/**
 * Show a one-line feedback message below the word display.
 * @param {string} msg
 * @param {string} cssClass  One of: 'feedback-ok', 'feedback-bad', 'feedback-info'
 */
export function showFeedback(msg, cssClass) {
  const el = document.getElementById('word-feedback');
  el.textContent = msg;
  el.className   = cssClass;
}

// ── Word history ───────────────────────────────────────────────────

/**
 * Re-render the word-history list.
 * @param {Array<{word: string, pts: number}>} history
 */
export function renderHistory(history) {
  document.getElementById('word-history').innerHTML = history
    .map(e =>
      `<div class="history-entry">` +
        `<span class="hw">${e.word}</span>` +
        `<span class="hp">+${e.pts}</span>` +
      `</div>`
    )
    .join('');
}

// ── Overlay ────────────────────────────────────────────────────────

/** Show the start screen (initial state). */
export function showStartScreen() {
  document.getElementById('overlay-title').textContent = 'TETROGGLEABLE';
  document.getElementById('overlay-msg').innerHTML =
    `Move blocks with <strong>← →</strong>, rotate with <strong>↑</strong>, ` +
    `hard-drop with <strong>Space</strong>.<br><br>` +
    `Type letters to spell words from settled blocks — ` +
    `hit <strong>Enter</strong> to score!<br><br>` +
    `Bonus tiles multiply your letter &amp; word scores. ` +
    `Words ≥ 7 letters get <strong>2×</strong>!`;
  document.getElementById('final-score').style.display = 'none';
  document.getElementById('start-btn').textContent = 'START GAME';
  document.getElementById('overlay').style.display = 'flex';
}

/**
 * Show the game-over screen with the player's final score.
 * @param {number} score
 */
export function showGameOverScreen(score) {
  document.getElementById('overlay-title').textContent = 'GAME OVER';
  document.getElementById('overlay-msg').textContent   = 'Better luck next time!';
  document.getElementById('final-score').textContent   = `Final Score: ${score.toLocaleString()}`;
  document.getElementById('final-score').style.display = 'block';
  document.getElementById('start-btn').textContent     = 'PLAY AGAIN';
  document.getElementById('overlay').style.display     = 'flex';
}

/** Hide the overlay (called when the game starts). */
export function hideOverlay() {
  document.getElementById('overlay').style.display = 'none';
}

/** Returns true if the overlay is currently visible. */
export function isOverlayVisible() {
  return document.getElementById('overlay').style.display !== 'none';
}
