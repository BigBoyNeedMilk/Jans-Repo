int down, right, down1, right1;
int p0,p1;//for doublehop
boolean click;//første click for at vælge en brik, og derefter rykke den
boolean WHITE = true;
boolean BLACK = false;
boolean turn;//spillerens tur
boolean promote;
boolean doubleJump, jumping;
boolean gameOver;
PImage whiteKing, redKing, whitePawn, redPawn; 
PImage[][] board;

//restart knap
void keyPressed() {
  if (key=='r') startPosition();
}


void setup() {
  size(640, 640);
  noStroke();
  textSize(width/8);
  textAlign(CENTER);

  whiteKing = loadImage("Konge.png");
  redKing = loadImage("Konge1.png");
  whitePawn = loadImage("Bonde.png");
  redPawn = loadImage("Bonde1.png");
  whiteKing.resize(width/8, height/8);
  redKing.resize(width/8, height/8);
  whitePawn.resize(width/8, height/8);
  redPawn.resize(width/8, height/8);
  startPosition();
}
void draw() {
  showBoard();
  if (gameOver) {
    fill(0, 255, 0);
    text("SPIL OVER", 0, height/2, width, height);
  }
}
void showBoard() {
  for (int i = 0; i<8; i++)
    for (int j = 0; j<8; j++) { 
      if ((i+j)%2 == 0) fill(255, 255, 255);
      else fill(0, 0, 0);
      rect(i*width/8, j*height/8, width/8, height/8);//skakbræt
      if (board[j][i] != null) image(board[j][i], i*width/8, j*height/8);
      if (click) {
        if (validMove(down, right, j, i, turn, board)) {
          fill(255, 0, 0, 100);//highlight mulige ryk for rød
          rect(i*width/8, j*height/8, width/8, height/8);
        }
        if (j == down && i == right && board[j][i] != null) {
          fill(0, 0, 255, 100);//highlight brikkerne i blå
          rect(i*width/8, j*height/8, width/8, height/8);
        }
      }
    }
}
void mousePressed() {
  if (gameOver) startPosition();
  if (click) {
    down1 = round(mouseY / (height/8)-0.5);
    right1 = round(mouseX / (width/8)-0.5);
    if (validMove(down, right, down1, right1, turn, board)) {
      board = movePiece(down, right, down1, right1, board);//ryk brik
      click = false;
    } else {//skift brik
      down = down1;
      right = right1;
      click = true;
    }
  } else {
    down = round(mouseY / (height/8)-0.5);
    right = round(mouseX / (width/8)-0.5);
    click = true;
  }
}
void startPosition() { //position af alle brikkerne
  board = new PImage[8][8];

  board[0][1] = redPawn;
  board[0][3] = redPawn;
  board[0][5] = redPawn; 
  board[0][7] = redPawn;
  board[1][0] = redPawn;
  board[1][2] = redPawn;
  board[1][4] = redPawn;
  board[1][6] = redPawn;
  board[2][1] = redPawn;
  board[2][3] = redPawn;
  board[2][5] = redPawn; 
  board[2][7] = redPawn;

  board[5][0] = whitePawn;
  board[5][2] = whitePawn;
  board[5][4] = whitePawn;
  board[5][6] = whitePawn;
  board[6][1] = whitePawn;
  board[6][3] = whitePawn;
  board[6][5] = whitePawn;
  board[6][7] = whitePawn;
  board[7][0] = whitePawn;
  board[7][2] = whitePawn;
  board[7][4] = whitePawn;
  board[7][6] = whitePawn;

  //globale variabler
  promote = false;
  down=right=down1=right1=-1;
  click = false;
  turn = WHITE;
  gameOver = false;
  doubleJump = false;
}
PImage[][] movePiece(int i0, int j0, int i1, int j1, PImage[][] Board) {
  if (Board[i0][j0] == whitePawn) {
    if (i1 == 0) {
      Board[i0][j0] = whiteKing;
      promote = true;
      doubleJump = false;
    }
  } else if (Board[i0][j0] == redPawn) {
    if (i1 == 7) {
      Board[i0][j0] = redKing;
      promote = true;
      doubleJump = false;
    }
  }
  Board[i1][j1] = Board[i0][j0];//ryk brikker
  Board[i0][j0] = null;//fjern original brik
  if (abs(j0 - j1) == 2) {//jump
    Board[(i0 + i1)/2][(j0 + j1)/2] = null;
    if (!promote) {//man kan hoppe igen
      if (validMove(i1, j1, i1+2, j1+2, turn, Board) || validMove(i1, j1, i1+2, j1-2, turn, Board) ||
        validMove(i1, j1, i1-2, j1+2, turn, Board) || validMove(i1, j1, i1-2, j1-2, turn, Board)) {
        turn = !turn;
        doubleJump = true;
        p0 = i1;
        p1 = j1;
      } else {
        doubleJump = false;
      }
    }
  }
  promote = false;
  if(mustJump(!turn)){
    jumping = true;
  }else{
    jumping = false;
  }
  if (finish(!turn)) {//ingen ryk tilbage
    gameOver = true;
  }
  turn = !turn;
  return Board;
}
boolean finish(boolean side) {//ingen ryk tilbage
  for (int k = 0; k<8; k++) {
    for (int l = 0; l<8; l++) {
      if (side == WHITE) {
        if (notWhite(l, k, board))
          continue;
      } else if (notBlack(l, k, board)) {
        continue;
      }
      for (int i = 0; i<8; i++) {
        for (int j = 0; j<8; j++) {
          if (validMove(l, k, i, j, side, board)) return false;
        }
      }
    }
  }
  return true;
}
boolean mustJump(boolean side) {
  for (int k = 0; k<8; k++) {
    for (int l = 0; l<8; l++) {
      if (side == WHITE) {
        if (notWhite(l, k, board))
          continue;
      } else if (notBlack(l, k, board)) {
        continue;
      }
      for (int i = 0; i<8; i++) {
        for (int j = 0; j<8; j++) {
          if (validMove(l, k, i, j, side, board) && abs(l-i)==2) return true;
        }
      }
    }
  }
  return false;
}
boolean validMove(int down, int right, int down1, int right1, boolean side, PImage[][] Board) {
  if (down > 7 ||  down < 0 || down1 > 7 ||  down1 < 0 || right > 7 ||  right < 0 || right1 > 7 ||  right1 < 0) {
    return false;
  }
  if(doubleJump){
    if(down!=p0 || right != p1 || abs(right1-right) != 2) return false;
  }
  if(jumping){
    if(abs(right1-right) != 2) return false;
  }
  if (side == WHITE) {//hvid
    if (Board[down][right] == whitePawn) {
      if (abs(right1 - right) == 1 && down1 == down-1 && Board[down1][right1] == null) { // ryk 1 fremad
        return true;
      }
      if (abs(right1 - right) == 2 && down1 == down-2 && Board[down1][right1] == null && 
        black(down-1, (right + right1)/2, Board)) { //hop
        return true;
      }
    } else if (Board[down][right] == whiteKing) {
      if (abs(right1 - right) == 1 && abs(down1-down) == 1 && Board[down1][right1] == null) { // ryk 1 fremad
        return true;
      }
      if (abs(right1 - right) == 2 && abs(down1-down) == 2 && Board[down1][right1] == null 
        && black((down+down1)/2, (right + right1)/2, Board)) { //hop
        return true;
      }
    }
  } else {
    if (Board[down][right] == redPawn) {
      if (abs(right1 - right) == 1 && down1 == down+1 && Board[down1][right1] == null) { // ryk 1 fremad
        return true;
      }
      if (abs(right1 - right) == 2 && down1 == down+2 && Board[down1][right1] == null && 
        white(down+1, (right + right1)/2, Board)) { //hop
        return true;
      }
    } else if (Board[down][right] == redKing) {
      if (abs(right1 - right) == 1 && abs(down1-down) == 1 && Board[down1][right1] == null) { // ryk 1 fremad
        return true;
      }
      if (abs(right1 - right) == 2 && abs(down1-down) == 2 && Board[down1][right1] == null && 
        white((down+down1)/2, (right + right1)/2, Board)) { //hop
        return true;
      }
    }
  }
  return false;
}
boolean black (int down1, int right1, PImage[][] Board) {
  return (Board[down1][right1] == redPawn || Board[down1][right1] == redKing);
}
boolean white (int down1, int right1, PImage[][] Board) {
  return (Board[down1][right1] == whitePawn || Board[down1][right1] == whiteKing);
}
boolean notBlack (int down1, int right1, PImage[][] Board) {
  return (white(down1, right1, Board) || Board[down1][right1] ==null);
}
boolean notWhite (int down1, int right1, PImage[][] Board) {
  return (black(down1, right1, Board) || Board[down1][right1] ==null);
}
