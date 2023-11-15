// For all shop links, scroll parent to top on click
const debug = false;
let parent_scroll_top_enabled = true;

if (window.self !== window.top) {
    if (debug) {
        console.log("Inside an iframe, parent-scroll-top enabled");
    }
} else {
    if (debug) {
        console.log("Not inside an iframe, parent-scroll-top disabled");
    }
    parent_scroll_top_enabled = false;
}

function waitForIframeResizer() {
    if (!parent_scroll_top_enabled) {
        return;
    }

    if (window.parentIFrame) {
        if (debug) {
            console.log("iFrameResizer found!");
        }
        setupLinks();
    } else {
        if (debug) {
            console.log("iFrameResizer not found, looking again...");
        }
        setTimeout(waitForIframeResizer, 500);
    }
}

waitForIframeResizer();

function setupLinks() {
    try {
        document.querySelectorAll('.oe_website_sale a[itemprop="url"]').forEach(function (link) {
            if (debug) {
                console.log('parent-scroll-top, attaching to link:' + link.href);
            }
            link.addEventListener('click', function(event) {
                if (debug) {
                    console.info('parent-scroll-top: link clicked, scrolling!');
                }
                window.parentIFrame.scrollTo(0,0);
            });
        });
    } catch(error) {
        if (debug) {
            console.info('parent-scroll-top: ' + error);
        }
    }
}
