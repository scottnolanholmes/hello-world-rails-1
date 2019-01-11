export default {
  Down(speed) {
    const position = $('html').height();
    $('html').animate({scrollTop: position}, speed);
  }
}
