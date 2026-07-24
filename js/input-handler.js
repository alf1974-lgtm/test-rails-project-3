/**
 * Input handler module
 * Manages keyboard input and user interactions
 */

class InputHandler {
    /**
     * Setup all event listeners for the game
     * @param {Game} gameInstance - Reference to the game instance
     */
    static setupEventListeners(gameInstance) {
        document.addEventListener('keydown', (e) => this.handleKeyPress(e, gameInstance));
        document.getElementById('wordInput').addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                gameInstance.submitWord();
            }
        });
    }

    /**
     * Handle keyboard input for game controls
     * @param {KeyboardEvent} e - The keyboard event
     * @param {Game} gameInstance - Reference to the game instance
     */
    static handleKeyPress(e, gameInstance) {
        if (gameInstance.gameOver) return;

        switch (e.key) {
            case 'ArrowLeft':
                e.preventDefault();
                gameInstance.movePiece(-1, 0);
                break;
            case 'ArrowRight':
                e.preventDefault();
                gameInstance.movePiece(1, 0);
                break;
            case 'ArrowUp':
                e.preventDefault();
                gameInstance.rotatePiece();
                break;
            case ' ':
                e.preventDefault();
                gameInstance.dropPiece();
                break;
        }
    }
}
