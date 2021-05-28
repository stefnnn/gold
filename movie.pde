import com.hamoid.*;

VideoExport movie;

// Press 'q' to finish saving the movie and exit.

// In some systems, if you close your sketch by pressing ESC, 
// by closing the window, or by pressing STOP, the resulting 
// movie might be corrupted. If that happens to you, use
// videoExport.endMovie() like you see in this example.

// In other systems pressing ESC produces correct movies
// and .endMovie() is not necessary.

void setupMovie() {
  movie = new VideoExport(this, "gold.mp4");
  //movie.forgetFfmpegPath();
  movie.setDebugging(false);
  if (movieStart) movie.startMovie();
}
void recordMovie() {
  movie.saveFrame();
}


void keyPressed() {
  if (key == 's') {
    movie.startMovie();
  } 
  if (key == 'q') {
    movie.endMovie();
    exit();
  }
}
