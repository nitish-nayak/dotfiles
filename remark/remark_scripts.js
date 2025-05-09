var slideshow = remark.create({
    highlightStyle: 'monokai',
    highlightLanguage: 'remark',
    highlightLines: false,
    ratio: '16:9'
});

function applyDynamicGridLayout(slideContentEl) { // Parameter renamed for clarity, still .remark-slide-content

    const classList = slideContentEl.className.split(' '); // Read classes from .remark-slide
    const layoutClassMatch = classList.find(cls => /^layout-\d+x\d+$/.test(cls));

    // The rest of the function correctly uses slideContentEl to find .grid-layout
    const gridLayoutContainer = slideContentEl.querySelector('.grid-layout');
    if (!gridLayoutContainer) {
        console.warn('Slide has layout-NxM class but no .grid-layout container found.');
        return;
    }

    const [rows, cols] = layoutClassMatch.replace('layout-', '').split('x').map(Number);

    gridLayoutContainer.style.display = 'grid';
    gridLayoutContainer.style.gridTemplateColumns = `repeat(${cols}, 1fr)`;
    gridLayoutContainer.style.gridTemplateRows = `repeat(${rows}, 1fr)`;
    gridLayoutContainer.style.gap = '1em'; // Consistent with your original styling

    const cells = gridLayoutContainer.querySelectorAll('[class^=cell-]');
    cells.forEach(cell => {
        const cellClassMatch = cell.className.match(/cell-(\d)(\d)/);
        if (cellClassMatch) {
            const [, row, col] = cellClassMatch.map(Number);
            cell.style.gridRow = row;
            cell.style.gridColumn = col;
        }
    });
}

let selectedWrapper = null;
function setupInteractForWrapper(wrapperElement) {
    interact(wrapperElement)
        .draggable({
            modifiers: [
                interact.modifiers.snap({
                    targets: [ interact.snappers.grid({ x: 5, y: 5 }) ], // Snap to a grid of 5x5 pixels during drag.
                    range: Infinity,
                    relativePoints: [ { x: 0, y: 0 } ]
                })
            ],
            listeners: {
                move(event) {
                    const target = event.target;
                    const x = (parseFloat(target.getAttribute('data-x')) || 0) + event.dx;
                    const y = (parseFloat(target.getAttribute('data-y')) || 0) + event.dy;
                    target.style.transform = `translate(${x}px, ${y}px)`;
                    target.setAttribute('data-x', x);
                    target.setAttribute('data-y', y);
                }
            }
        })
        .resizable({
            edges: { left: true, right: true, bottom: true, top: true },
            modifiers: [
                interact.modifiers.aspectRatio({ ratio: 'preserve', }),
                interact.modifiers.snap({
                    targets: [ interact.snappers.grid({ x: 5, y: 5 }) ],
                    range: Infinity,
                    relativePoints: [ { x: 0, y: 0 } ]
                }),
            ],
            listeners: {
                move(event) {
                    let { x, y } = event.target.dataset; // transform translations
                    x = parseFloat(x) || 0;
                    y = parseFloat(y) || 0;

                    event.target.style.width = `${event.rect.width}px`;
                    event.target.style.height = `${event.rect.height}px`;

                    x += event.deltaRect.left;
                    y += event.deltaRect.top;

                    event.target.style.transform = `translate(${x}px, ${y}px)`;
                    event.target.dataset.x = x;
                    event.target.dataset.y = y;
                }
            }
        });
}

function makeImagesInteractive() {
    const slideContentEl = document.querySelector('.remark-visible .remark-slide-content');
    if (!slideContentEl) {
        return;
    }
    slideContentEl.querySelectorAll('img').forEach((img) => {
        if (img.closest('.resize-drag')) return;

        const wrapper = document.createElement('div');
        wrapper.className = 'resize-drag';
        wrapper.style.left = img.offsetLeft + 'px';
        wrapper.style.top = img.offsetTop + 'px';
        wrapper.style.width = img.width + 'px';
        wrapper.style.height = img.height + 'px';

        img.style.width = '100%';
        img.style.height = '100%';
        img.style.position = 'relative';

        const parent = img.parentNode;
        parent.insertBefore(wrapper, img);
        wrapper.appendChild(img);

        wrapper.addEventListener('click', function (e) {
            e.stopPropagation();
            document.querySelectorAll('.resize-drag').forEach(w => w.classList.remove('selected'));
            wrapper.classList.add('selected');
            selectedWrapper = wrapper;
        });

        setupInteractForWrapper(wrapper);
    });
}

function addImage() {
    const url = document.getElementById('imgUrl').value;
    const currentSlide = document.querySelector('.remark-visible .remark-slide-content');
    const img = document.createElement('img');
    img.src = url;
    img.className = 'draggable';
    img.style.width = '200px';
    currentSlide.appendChild(img);
    makeImagesInteractive();
}

function saveLayout() {
    const data = [];
    document.querySelectorAll('.resize-drag').forEach(wrapper => {
        const img = wrapper.querySelector('img');
        data.push({
            src: img.src,
            width: wrapper.style.width,
            height: wrapper.style.height,
            x: wrapper.getAttribute('data-x') || 0,
            y: wrapper.getAttribute('data-y') || 0
        });
    });
    const currentIndex = slideshow.getCurrentSlideIndex();
    const allLayouts = JSON.parse(localStorage.getItem('slide-layout') || '{}');
    allLayouts[currentIndex] = data;
    localStorage.setItem('slide-layout', JSON.stringify(allLayouts));

    alert('Layout saved.');
}

function loadLayout() {
    const currentIndex = slideshow.getCurrentSlideIndex();
    const allLayouts = JSON.parse(localStorage.getItem('slide-layout') || '{}');
    const data = allLayouts[currentIndex] || [];

    const currentSlide = document.querySelector('.remark-visible .remark-slide-content');
    data.forEach(imgData => {
        const img = document.createElement('img');
        img.src = imgData.src;
        img.className = 'draggable';
        const wrapper = document.createElement('div');
        wrapper.className = 'resize-drag';
        wrapper.style.width = imgData.width;
        wrapper.style.height = imgData.height;
        wrapper.setAttribute('data-x', imgData.x);
        wrapper.setAttribute('data-y', imgData.y);
        wrapper.style.transform = `translate(${imgData.x}px, ${imgData.y}px)`;
        img.style.width = '100%';
        img.style.height = '100%';
        img.style.position = 'relative';
        currentSlide.appendChild(wrapper);
        wrapper.appendChild(img);
        wrapper.addEventListener('click', function (e) {
            e.stopPropagation();
            document.querySelectorAll('.resize-drag').forEach(w => w.classList.remove('selected'));
            wrapper.classList.add('selected');
            selectedWrapper = wrapper;
        });
        setupInteractForWrapper(wrapper);
    });
}

function deleteSelected() {
    if (selectedWrapper) {
        selectedWrapper.remove();
        selectedWrapper = null;
    }
}

function downloadHTML() {
    const doctype = new XMLSerializer().serializeToString(document.doctype);
    const html = document.documentElement.cloneNode(true);
    const serializer = new XMLSerializer();
    const htmlString = doctype + serializer.serializeToString(html);

    const blob = new Blob([htmlString], { type: 'text/html' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    // Extract title and format filename
    const title = document.title || 'presentation';
    const safeTitle = title.toLowerCase().replace(/[^a-z0-9]+/g, '_').replace(/^_|_$/g, '');
    a.download = `${safeTitle}_layout.html`;

    a.click();
    URL.revokeObjectURL(url);
}

document.addEventListener('click', () => {
    document.querySelectorAll('.resize-drag').forEach(w => w.classList.remove('selected'));
    selectedWrapper = null;
});

slideshow.on('afterShowSlide', () => {
    selectedWrapper = null;
    makeImagesInteractive();
    const slideEl = document.querySelector('.remark-visible .remark-slide-content');
    if (slideEl) {
        applyDynamicGridLayout(slideEl);
    }
});

slideshow.on('ready', function() {
    var d = document, s = d.createElement("style"), r = d.querySelector(".remark-slide-scaler");
    if (!r) return;
    s.type = "text/css";
    s.innerHTML = "@page { size: " + r.style.width + " " + r.style.height +"; }";
    d.head.appendChild(s);
});
