/**
 * letters.js
 * Utility functions for randomly picking letters and bonus tile types.
 */

import { LETTER_POOL, BONUS } from './constants.js';

/**
 * Returns a random uppercase letter sampled from the Scrabble-frequency pool.
 * @returns {string}
 */
export function randomLetter() {
  return LETTER_POOL[Math.floor(Math.random() * LETTER_POOL.length)];
}

/**
 * Returns a random bonus type, weighted so that bonus tiles are relatively
 * rare (≈30 % of blocks get any bonus at all).
 *
 * Approximate rates:
 *   TW  4 %
 *   DW  6 %
 *   TL  8 %
 *   DL 12 %
 *   NONE 70 %
 *
 * @returns {string}  One of the BONUS constants.
 */
export function randomBonus() {
  const r = Math.random();
  if (r < 0.04) return BONUS.TW;
  if (r < 0.10) return BONUS.DW;
  if (r < 0.18) return BONUS.TL;
  if (r < 0.30) return BONUS.DL;
  return BONUS.NONE;
}
