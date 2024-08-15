# Tetris

# Components
#### GameScreen: The main game screen where the Tetris game is played.
#### Pixel: Widget representing the active/landed Tetris block pixel or the blank game grid pixel.


# Game Mechanics
## Blocks: 
#### Various Tetris blocks such as Line, Square, J-block, H-block, L-block, N-block, S-block, T-block, and Z-block.
## Movement:
#### moveRight(): Moves the active block to the right if there is no boundary or other block in the way.
#### moveLeft(): Moves the active block to the left if there is no boundary or other block in the way.
#### moveDown(): Moves the active block down.\n
## Game Loop: 
#### The game loop runs every 400 milliseconds, moving the active block down and checking for completed rows.
#### Row Completion: When a row is completely filled, it is removed, and all blocks above it move down.

