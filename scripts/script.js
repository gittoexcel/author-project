
fetch('scripts/about.php')
    .then(response => response.json())
    .then(data => {
        generateBooks(data);
    })
    .catch(error => console.error('Error loading JSON:', error));


function generateBooks(books) {
    let catalogue = document.querySelector('.book-catalogue');

    books.forEach(book => {

        let container = document.createElement("div");
        container.classList.add("container", "p-5");

        let row = document.createElement("div");
        row.classList.add("row");

        // img side
        let colImg = document.createElement("div");
        colImg.classList.add("col-md-6", "pb-5");
        colImg.innerHTML = `<img src="${book.image_url}" class="img rounded shadow-lg d-block m-auto" alt="Sample Art">`;

        // book stuff
        let colContent = document.createElement("div");
        colContent.classList.add("col-md-6", "align-content-center", "text-center");

        let title = document.createElement("h2");
        title.innerText = book.title;

        // Related Content
        let relatedContent = document.createElement("h3");
        relatedContent.classList.add("pt-5");
        relatedContent.innerText = "Related content";

        let ul = document.createElement("ul");
        ul.classList.add("d-inline-block", "text-start", "pb-1");
        if (book.related && Object.keys(book.related).length > 0) {
            let relatedObj = book.related;
            Object.keys(relatedObj).forEach(key => {
                console.log(relatedObj[key])
                if (relatedObj[key] != null) {
                    let li = document.createElement("li");
                    li.innerHTML = `<a href="${relatedObj[key]}">${key}</a>`;
                    ul.appendChild(li);
                }
            });
        }
        // Buttons
        let btnRow = document.createElement("div");
        btnRow.classList.add("row", "justify-content-evenly");

        if (book.buttons && Object.keys(book.buttons).length > 0) {
            let btnObj = book.buttons;
            Object.keys(btnObj).forEach(key => {
                if (btnObj[key] != null) {
                    let btn = document.createElement("div");
                    btn.classList.add("btn", "col-5");
                    btn.setAttribute("onclick", `location.href='${btnObj[key]}'`);
                    btn.textContent = key

                    if (key === "Read") {
                        btn.classList.add("btn-secondary");
                    } else {
                        btn.classList.add("btn-outline-secondary");
                    }

                    btnRow.appendChild(btn);
                }
            });
        }

        colContent.appendChild(title);
        colContent.appendChild(relatedContent);
        colContent.appendChild(ul);
        colContent.appendChild(btnRow);

        row.appendChild(colImg);
        row.appendChild(colContent);

        container.appendChild(row);
        catalogue.appendChild(container);
    });
}
