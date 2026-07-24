/**
 * constants.js
 * All shared, immutable game constants: board dimensions, bonus types,
 * colour maps, Scrabble letter values, and tetromino definitions.
 */

// ── Board dimensions ───────────────────────────────────────────────
export const COLS = 10;
export const ROWS = 20;
export const CELL = 30; // px per cell

// ── Bonus tile identifiers ─────────────────────────────────────────
export const BONUS = Object.freeze({
  NONE: 'none',
  DL:   'dl',   // double letter  – light blue
  TL:   'tl',   // triple letter  – dark blue
  DW:   'dw',   // double word    – light pink
  TW:   'tw',   // triple word    – dark pink
});

/** Canvas fill colour for each bonus type (null = use piece colour). */
export const BONUS_COLORS = Object.freeze({
  [BONUS.NONE]: null,
  [BONUS.DL]:   '#90e0ef',
  [BONUS.TL]:   '#0077b6',
  [BONUS.DW]:   '#ffb3c6',
  [BONUS.TW]:   '#e05c8a',
});

/** Text colour that contrasts well against each bonus background. */
export const BONUS_TEXT_COLORS = Object.freeze({
  [BONUS.NONE]: '#ffffff',
  [BONUS.DL]:   '#003049',
  [BONUS.TL]:   '#ffffff',
  [BONUS.DW]:   '#6b0020',
  [BONUS.TW]:   '#ffffff',
});

// ── Scrabble letter point values ───────────────────────────────────
export const LETTER_VALUES = Object.freeze({
  A: 1, E: 1, I: 1, O: 1, U: 1, L: 1, N: 1, S: 1, T: 1, R: 1,
  D: 2, G: 2,
  B: 3, C: 3, M: 3, P: 3,
  F: 4, H: 4, V: 4, W: 4, Y: 4,
  K: 5,
  J: 8, X: 8,
  Q: 10, Z: 10,
});

/**
 * Scrabble-frequency letter pool.
 * Each letter appears as many times as its standard Scrabble tile count,
 * giving a realistic distribution when sampling randomly.
 */
export const LETTER_POOL = (function buildPool() {
  const freq = {
    A: 9,  B: 2,  C: 2,  D: 4,  E: 12, F: 2,  G: 3,  H: 2,
    I: 9,  J: 1,  K: 1,  L: 4,  M: 2,  N: 6,  O: 8,  P: 2,
    Q: 1,  R: 6,  S: 4,  T: 6,  U: 4,  V: 2,  W: 2,  X: 1,
    Y: 2,  Z: 1,
  };
  const pool = [];
  for (const [letter, count] of Object.entries(freq)) {
    for (let i = 0; i < count; i++) pool.push(letter);
  }
  return Object.freeze(pool);
})();

// ── Tetromino definitions ──────────────────────────────────────────
// Each entry: { color, rotations }
// rotations: array of 4 states, each state is an array of [rowOffset, colOffset] pairs.
export const PIECES = Object.freeze([
  // I
  {
    color: '#00b4d8',
    rotations: [
      [[0, 0], [0, 1], [0, 2], [0, 3]],
      [[0, 0], [1, 0], [2, 0], [3, 0]],
      [[0, 0], [0, 1], [0, 2], [0, 3]],
      [[0, 0], [1, 0], [2, 0], [3, 0]],
    ],
  },
  // O
  {
    color: '#f9c74f',
    rotations: [
      [[0, 0], [0, 1], [1, 0], [1, 1]],
      [[0, 0], [0, 1], [1, 0], [1, 1]],
      [[0, 0], [0, 1], [1, 0], [1, 1]],
      [[0, 0], [0, 1], [1, 0], [1, 1]],
    ],
  },
  // T
  {
    color: '#9b5de5',
    rotations: [
      [[0, 0], [0, 1], [0, 2], [1, 1]],
      [[0, 0], [1, 0], [2, 0], [1, 1]],
      [[1, 0], [1, 1], [1, 2], [0, 1]],
      [[0, 1], [1, 1], [2, 1], [1, 0]],
    ],
  },
  // S
  {
    color: '#57cc99',
    rotations: [
      [[0, 1], [0, 2], [1, 0], [1, 1]],
      [[0, 0], [1, 0], [1, 1], [2, 1]],
      [[0, 1], [0, 2], [1, 0], [1, 1]],
      [[0, 0], [1, 0], [1, 1], [2, 1]],
    ],
  },
  // Z
  {
    color: '#e94560',
    rotations: [
      [[0, 0], [0, 1], [1, 1], [1, 2]],
      [[0, 1], [1, 0], [1, 1], [2, 0]],
      [[0, 0], [0, 1], [1, 1], [1, 2]],
      [[0, 1], [1, 0], [1, 1], [2, 0]],
    ],
  },
  // J
  {
    color: '#f77f00',
    rotations: [
      [[0, 0], [1, 0], [1, 1], [1, 2]],
      [[0, 0], [0, 1], [1, 0], [2, 0]],
      [[0, 0], [0, 1], [0, 2], [1, 2]],
      [[0, 1], [1, 1], [2, 0], [2, 1]],
    ],
  },
  // L
  {
    color: '#4cc9f0',
    rotations: [
      [[0, 2], [1, 0], [1, 1], [1, 2]],
      [[0, 0], [1, 0], [2, 0], [2, 1]],
      [[0, 0], [0, 1], [0, 2], [1, 0]],
      [[0, 0], [0, 1], [1, 1], [2, 1]],
    ],
  },
]);
