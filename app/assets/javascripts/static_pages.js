function updateCounter() {
    // 100 is the min message length
    var written = $('#newPageContent').val().length;
    $('.counter').text(written + ' characters');
}

$(function() {
    updateCounter();
    $('#newPageContent').change(updateCounter);
    $('#newPageContent').keyup(updateCounter);
});
