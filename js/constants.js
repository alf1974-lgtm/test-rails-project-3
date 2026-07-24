/**
 * Constants for the Tetroggleable game
 * Includes board dimensions, piece definitions, and game configuration
 */

// Scrabble letter point values
const LETTER_VALUES = {
    'A': 1, 'B': 3, 'C': 3, 'D': 2, 'E': 1, 'F': 4, 'G': 2, 'H': 4, 'I': 1, 'J': 8,
    'K': 5, 'L': 1, 'M': 3, 'N': 1, 'O': 1, 'P': 3, 'Q': 10, 'R': 1, 'S': 1, 'T': 1,
    'U': 1, 'V': 4, 'W': 4, 'X': 8, 'Y': 4, 'Z': 10
};

// Tetris pieces (Tetrominos) with shapes and colors
const PIECES = [
    { name: 'I', shape: [[1, 1, 1, 1]], color: '#00F0F0' },
    { name: 'O', shape: [[1, 1], [1, 1]], color: '#F0F000' },
    { name: 'T', shape: [[0, 1, 0], [1, 1, 1]], color: '#A000F0' },
    { name: 'S', shape: [[0, 1, 1], [1, 1, 0]], color: '#00F000' },
    { name: 'Z', shape: [[1, 1, 0], [0, 1, 1]], color: '#F00000' },
    { name: 'J', shape: [[1, 0, 0], [1, 1, 1]], color: '#0000F0' },
    { name: 'L', shape: [[0, 0, 1], [1, 1, 1]], color: '#F0A500' }
];

// Board dimensions
const BOARD_WIDTH = 10;
const BOARD_HEIGHT = 20;

// Game configuration
const BONUS_CHANCE = 0.15; // 15% chance for bonus tiles on new blocks
const GAME_SPEED = 1000; // milliseconds between automatic drops
const POINTS_PER_LINE = 10; // points awarded for clearing a line
const WORD_HISTORY_MAX = 10; // maximum words to display in history
