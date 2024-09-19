
const control_item_buttons = `
    <div class="d-flex justify-content-end">
            <div class="mx-2 edit_item_name_container" data-bs-toggle="tooltip" data-bs-placement="left" title="Rename book">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-pencil-square edit_book_name_svg" viewBox="0 0 16 16">
                    <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
                    <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z"/>
                </svg>
            </div>
            <div class="mx-2 remove_item_container" data-bs-toggle="tooltip" data-bs-placement="right" title="Remove book">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" class="bi bi-trash3 remove_book_svg" viewBox="0 0 16 16">
                    <path d="M6.5 1h3a.5.5 0 0 1 .5.5v1H6v-1a.5.5 0 0 1 .5-.5M11 2.5v-1A1.5 1.5 0 0 0 9.5 0h-3A1.5 1.5 0 0 0 5 1.5v1H1.5a.5.5 0 0 0 0 1h.538l.853 10.66A2 2 0 0 0 4.885 16h6.23a2 2 0 0 0 1.994-1.84l.853-10.66h.538a.5.5 0 0 0 0-1zm1.958 1-.846 10.58a1 1 0 0 1-.997.92h-6.23a1 1 0 0 1-.997-.92L3.042 3.5zm-7.487 1a.5.5 0 0 1 .528.47l.5 8.5a.5.5 0 0 1-.998.06L5 5.03a.5.5 0 0 1 .47-.53Zm5.058 0a.5.5 0 0 1 .47.53l-.5 8.5a.5.5 0 1 1-.998-.06l.5-8.5a.5.5 0 0 1 .528-.47M8 4.5a.5.5 0 0 1 .5.5v8.5a.5.5 0 0 1-1 0V5a.5.5 0 0 1 .5-.5"/>
                </svg>
            </div>
        </div>
`;

const add_item_button = `
    <div id="add_item_button" style="width: 50px;" class="btn btn-outline-success d-flex ms-auto me-2" data-bs-toggle="tooltip" data-bs-placement="left" title="Add item">
        <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" fill="currentColor" class="bi bi-plus-circle" viewBox="0 0 16 16">
         <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
            <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4"/>
        </svg>
    </div>
`;

export const table_head_template = `
        <thead>
        <tr>
            <th scope="col">#</th>
            <th scope="col">{item_name}</th>
            <th scope="col">${add_item_button}</th>
        </tr>
        </thead>
        <tbody></tbody>
`;

export const table_item_template_HTML = `
        <tr id="{item.id}">
                <th scope="row">{index}</th>
                <td class="item_name">{item.name}</td>
                <td>
                   ${control_item_buttons}
                </td>
            </tr>
`;

export const verb_type_select = `
    <select class="form-select">
        <option value="UNREGELMASIG">UNREGELMASIG</option>
        <option value="REGELMASIG" >REGELMASIG</option>
    </select>
`;

export const help_verb_select = `
    <select class="form-select">
        <option value="ist">ist</option>
        <option value="hat" >hat</option>
    </select>
`;

export const article_select = `
    <select class="form-select">
        <option value="der">der</option>
        <option value="die" >die</option>
        <option value="das" >das</option>
    </select>
`;


export const word_item = `
            <tr id="{id}" data-item-type="word">
                <th scope="row">{index}</th>
                <td class="item_name"><input class="form-control expandable" type="text"></td>
                <td><input class="form-control" type="text"></td>
                <td>
                    <select class="word_type form-select"">
                        <option value="NOUN">NOMEN</option>
                        <option value="ADJECTIVE" selected>ADJECTIVE</option>
                        <option value="VERB">VERB</option>
                        <option value="TRENNBARES_VERB">TRENNBARES_VERB</option>
                    </select>
                </td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td>
                   ${control_item_buttons}
                </td>
            </tr>
`;



export const book_item_template_HTML = `
    <li class="list-group-item book_item" id="{bookID}">
        <h5 class="my-0 px-1 text-white book_item_title">{bookTitle}</h5>
        ${control_item_buttons}
    </li>
`;

