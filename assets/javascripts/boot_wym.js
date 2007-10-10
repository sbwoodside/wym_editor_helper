var $j = jQuery.noConflict();
$j(function() {
	$j('.wymeditor').wymeditor({
        xhtmlParser: 'xhtml_parser.js',
        cssParser:   'wym_css_parser.js'
    });
});