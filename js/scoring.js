/**
 * scoring.js
 * Pure scoring logic: Scrabble letter values, bonus multipliers,
 * and the long-word bonus.  No side-effects or DOM access.
 */

import { LETTER_VALUES, BONUS } from './constants.js';

/**
 * Calculate the point value for a successfully played word.
 *
 * Rules (applied in order):
 *  1. Each letter's base value comes from LETTER_VALUES.
 *  2. DL tiles double that letter's value; TL tiles triple it.
 *  3. Sum all (possibly multiplied) letter values.
 *  4. DW tiles double the word total; TW tiles triple it.
 *     Multiple word-multiplier tiles stack multiplicatively.
 *  5. Words of 7 or more letters receive an additional 2× bonus.
 *
 * @param {string}   word         The word that was played (uppercase).
 * @param {object[]} matchedCells Array of board cell objects for each letter
 *                                in the word: { letter, bonus, color }.
 * @returns {number}  Total points (always a positive integer).
 */
export function scoreWord(word, matchedCells) {
  let letterSum = 0;
  let wordMult  = 1;

  for (const cell of matchedCells) {
    let lv = LETTER_VALUES[cell.letter] ?? 1;

    if (cell.bonus === BONUS.DL) lv *= 2;
    if (cell.bonus === BONUS.TL) lv *= 3;

    letterSum += lv;

    if (cell.bonus === BONUS.DW) wordMult *= 2;
    if (cell.bonus === BONUS.TW) wordMult *= 3;
  }

  let total = letterSum * wordMult;
  if (word.length >= 7) total *= 2;

  return total;
}

/**
 * Calculate the Tetris line-clear bonus.
 *
 * Standard scoring table (multiplied by current level):
 *   1 line  →  10 pts
 *   2 lines →  30 pts
 *   3 lines →  60 pts
 *   4 lines → 100 pts
 *
 * @param {number} linesCleared  Number of rows cleared simultaneously (1–4).
 * @param {number} level         Current game level.
 * @returns {number}
 */
export function scoreClear(linesCleared, level) {
  const table = [0, 10, 30, 60, 100];
  return (table[Math.min(linesCleared, 4)] ?? 0) * level;
}
