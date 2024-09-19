
let selected_book;
let selected_topic;
let selected_section;
let book_list;

import {book_item_template_HTML} from "./admin_templates.js";
import {table_item_template_HTML} from "./admin_templates.js";
import {table_head_template} from "./admin_templates.js";
import {word_item} from "./admin_templates.js";
import {verb_type_select} from "./admin_templates.js";
import {help_verb_select} from "./admin_templates.js";
import {article_select} from "./admin_templates.js";

const csrfToken = $('meta[name="_csrf"]').attr('content');
const csrfHeader = $('meta[name="_csrf_header"]').attr('content');

const $book_items_container = $('div.book_list_ul_container ul');
const $table = $('table.table');
const $confirmation_modal = $('#confirm_modal');
const breadcrumbs = $('.breadcrumb');


$(document).ready(async function (){
    // get Book list
    book_list = await $.get('/api/get-all-books');

    //event Handlers
    initEventHandlers();

    // show book list on page
    renderBooks();
});

// Handlers functions
/////////////////////////////////////////////////////////////////////////////
function initEventHandlers(){
    handleBookEvents();
    handleTableEvents();
    handleBreadcrumbs();
}

// Book events
//////////////////////////////////////////////////////////////////////////////////////////
function handleBookEvents(){

    // Add book
    $('#add_book_button').on('click', function (event) {
        //show modal
        const $addBookModal = $('#addBookModal');
        //clear modal
        $addBookModal.find('#add_book_error_alert').hide();
        $addBookModal.find('#add_book_input').val('');
        $addBookModal.modal('show');

        // modal add book button click
        $('#add_book_modal_button').off('click').on('click',async function (e){
            let new_book_title = $addBookModal.find('#add_book_input').val();

            if (new_book_title.length > 0 ){
                let new_book = await sendAjaxRequest('/api/add-book', new_book_title, function (){$addBookModal.find('#add_book_error_alert').show(200)});
                book_list.push(new_book);
                renderBooks();
                $addBookModal.modal('hide');
            } else {
                alert('Enter book title');
            }
        });

    });


    //   Book main item click
    $book_items_container.on('click','li', function (event){
        event.stopPropagation();
        // init selected book
        selected_book = book_list.find(book => book.id === $(this).attr('id'));
        renderTopics();
    });

    // Edit book title
    $book_items_container.on('click', 'div.edit_item_name_container', function (event){
        event.stopPropagation();

        let $title_item = $(this).closest('li').find('.book_item_title');
        let current_book_title = $title_item.text();
        let bookID = $(this).closest('li').attr('id');

        // create input item with events handlers
        const $book_title_input = createInputWithHandlers('/api/update-book/', bookID, current_book_title, function (response){
            $title_item.text(response);
            book_list.find(book => book.id === bookID).title = response;
        });

        //input replace and focus select
        $title_item.html($book_title_input);
        $book_title_input.focus().select();
    });

    // Remove book
    $book_items_container.on('click', 'div.remove_item_container', function (event){
       event.stopPropagation();
        let $title_item = $(this).closest('li').find('.book_item_title');
        let current_book_title = $title_item.text();
        let bookID = $(this).closest('li').attr('id');

        $confirmation_modal.find('.modal_title').text('Remove book');
        $confirmation_modal.find('.modal_text').html('Do you want remove book: <h5>' + current_book_title +'</h5>');
        $confirmation_modal.modal('show');

        $confirmation_modal.find('#confirm_button').off('click').on('click', async function (event){
            await sendAjaxRequest('/api/remove-book', bookID);
            $title_item.parent().remove();
            book_list.splice(book_list.findIndex(book => book.id === bookID), 1);
            $confirmation_modal.modal('hide');
            breadcrumbs.empty();
            $table.empty();
        });

    });

}

// Table Events
//////////////////////////////////////////////////////////////////////////////////////////
function handleTableEvents(){

        //add item click
        $table.on('click', 'thead #add_item_button', function (event){
            let level = breadcrumbs.children().eq(-1).attr('data-level');
            let last_index = +$table.find('tbody').children().eq(-1).children().eq(0).text();


            let $input_item;
            let $table_item =  $(table_item_template_HTML.replace(/{index}/, last_index + 1));

            if (level === 'book'){
                $input_item = createInputTemplate('/api/add-topic', selected_book.id, function (response){
                    $table_item.find('.item_name').text(response.name);
                    selected_book.topics.push(response);
                    $table_item.attr('id', response.id);
                    $table_item.attr('data-item-type', 'topic');
                });
            } else if (level === 'topic'){
                $input_item = createInputTemplate('/api/add-section', selected_topic.id, function (response){
                    $table_item.find('.item_name').text(response.name);
                    selected_topic.sections.push(response);
                    $table_item.attr('id', response.id);
                    $table_item.attr('data-item-type', 'section');
                });
            } else if (level === 'section'){
                    $table_item = $(word_item.replace(/{index}/, last_index +1));

                    $table_item.find('select.word_type').on('change', function (event){
                        event.stopPropagation();
                        let select_value = $(this).val();

                        if (select_value === 'NOUN'){
                            $table_item.children().eq(1).html(createInputEmptyTemplate());
                            $table_item.children().eq(2).html(createInputEmptyTemplate());
                            $table_item.children().eq(4).html(article_select);
                            $table_item.children().eq(5).html(createInputEmptyTemplate());
                            $table_item.children().eq(6).html('');
                            $table_item.children().eq(7).html('');
                            $table_item.children().eq(8).html('');
                            $table_item.children().eq(9).html('');
                            $table_item.children().eq(10).html('');
                            $table_item.children().eq(11).html('');
                        } else if (select_value === 'VERB'){
                            $table_item.children().eq(1).html(createInputEmptyTemplate());
                            $table_item.children().eq(2).html(createInputEmptyTemplate());
                            $table_item.children().eq(4).html('');
                            $table_item.children().eq(5).html('');
                            $table_item.children().eq(6).html(createInputEmptyTemplate());
                            $table_item.children().eq(7).html(createInputEmptyTemplate());
                            $table_item.children().eq(8).html(help_verb_select);
                            $table_item.children().eq(9).html(createInputEmptyTemplate());
                            $table_item.children().eq(10).html(verb_type_select);
                            $table_item.children().eq(11).html('');
                        } else if (select_value === 'ADJECTIVE'){
                            $table_item.children().eq(1).html(createInputEmptyTemplate());
                            $table_item.children().eq(2).html(createInputEmptyTemplate());
                            $table_item.children().eq(4).html('');
                            $table_item.children().eq(5).html('');
                            $table_item.children().eq(6).html('');
                            $table_item.children().eq(7).html('');
                            $table_item.children().eq(8).html('');
                            $table_item.children().eq(9).html('');
                            $table_item.children().eq(10).html('');
                            $table_item.children().eq(11).html('');
                        } else if (select_value === 'TRENNBARES_VERB'){
                            $table_item.children().eq(1).html(createInputEmptyTemplate());
                            $table_item.children().eq(2).html(createInputEmptyTemplate());
                            $table_item.children().eq(4).html('');
                            $table_item.children().eq(5).html('');
                            $table_item.children().eq(6).html(createInputEmptyTemplate());
                            $table_item.children().eq(7).html(createInputEmptyTemplate());
                            $table_item.children().eq(8).html(help_verb_select);
                            $table_item.children().eq(9).html(createInputEmptyTemplate());
                            $table_item.children().eq(10).html(verb_type_select);
                            $table_item.children().eq(11).html(createInputEmptyTemplate());
                        }
                    });

                    $table_item.on('keydown', async function (event){
                        if (event.key === 'Enter'){
                            const children = $(this).children();
                            const word = children.eq(1).children().val();
                            const translate = children.eq(2).children().val();
                            const type = children.eq(3).children().val();
                            const article = children.eq(4).children().val();
                            const plural = children.eq(5).children().val();
                            const thirdPerson = children.eq(6).children().val();
                            const perfect = children.eq(7).children().val();
                            const helpVerb = children.eq(8).children().val();
                            const prataritum = children.eq(9).children().val();
                            const verbType = children.eq(10).children().val();
                            const prefix = children.eq(11).children().val();

                            const data = {
                                word: word,
                                translate: translate,
                                type: type,
                                article: article,
                                plural: plural,
                                thirdPerson:thirdPerson,
                                perfect: perfect,
                                hilfVerb: helpVerb,
                                prataritum:prataritum,
                                verbType:verbType,
                                prefix:prefix,
                                sectionID: selected_section.id
                            };
                            console.log(data);
                            let response = await sendAjaxRequestJSON('/api/add-word', data);

                            $table_item.children().eq(1).text(response.word);
                            $table_item.children().eq(2).text(response.wordTranslate);
                            $table_item.children().eq(3).text(response.type);
                            $table_item.children().eq(4).text(response.article);
                            $table_item.children().eq(5).text(response.pluralForm);
                            $table_item.children().eq(6).text(response.thirdPersonForm);
                            $table_item.children().eq(7).text(response.perfectForm);
                            $table_item.children().eq(8).text(response.hilfVerbVergangenheit);
                            $table_item.children().eq(9).text(response.prataritumForm);
                            $table_item.children().eq(10).text(response.verbType);
                            $table_item.children().eq(11).text(response.prefix);

                            $table_item.attr('id', response.id);
                            $table_item.attr('data-item-type', 'word');
                            selected_section.words.push(response);                        }
                    });

                    $table.find('tbody').append($table_item);
            }

            if (level === 'book' || level === 'topic'){
                $table_item.find('.item_name').html($input_item);
                $table.find('tbody').append($table_item);
                $input_item.focus();
            }
        });

        // tr click
        $table.on('click', 'tbody tr', function (event){
            const item_type = $(this).attr('data-item-type');

            if (item_type === 'topic') {
                // init selected topic
                selected_topic = selected_book.topics.find(topic => topic.id === $(this).attr('id'));

                renderSections();
            } else if (item_type === 'section') {
                selected_section = selected_topic.sections.find(section => section.id === $(this).attr('id'));
                renderWords();
            }
        });

        // edit item click
        $table.on('click', 'div.edit_item_name_container', function (event){
            event.stopPropagation();
            const item_type = $(this).closest('tr').attr('data-item-type');

            const $item_name = $(this).closest('tr').find('.item_name');
            const current_item_title = $item_name.text();
            const itemID = $(this).closest('tr').attr('id');
            let item_name_input;

            if (item_type === 'topic') {
                // create input item with events handlers
                item_name_input = createInputWithHandlers('/api/update-topic/', itemID, current_item_title, function (response) {
                    $item_name.text(response);
                    selected_book.topics.find(topic => topic.id === itemID).name = response;
                });
            } else if (item_type === 'section'){
                item_name_input = createInputWithHandlers('/api/update-section/', itemID, current_item_title, function (response) {
                    $item_name.text(response);
                    selected_topic.sections.find(section => section.id === itemID).name = response;
                });
            }

                $item_name.html(item_name_input);
                item_name_input.focus().select();

        });

        //Remove items
        $table.on('click', 'div.remove_item_container', async function (event) {
            event.stopPropagation();
            const $tr = $(this).closest('tr');
            const item_type = $tr.attr('data-item-type');
            const itemID = $tr.attr('id');
            const current_item_title = $tr.find('.item_name').text();



            if (item_type === 'topic'){
                $confirmation_modal.find('.modal_title').text('Remove topic');
                $confirmation_modal.find('.modal_text').html('Do you want remove topic: <h5>' + current_item_title +'</h5>');

            } else if (item_type === 'section'){
                $confirmation_modal.find('.modal_title').text('Remove section');
                $confirmation_modal.find('.modal_text').html('Do you want remove sub-topic: <h5>' + current_item_title +'</h5>');
            } else if (item_type === 'word'){
                $confirmation_modal.find('.modal_title').text('Remove word');
                $confirmation_modal.find('.modal_text').html('Do you want remove word : <h5>' + current_item_title +'</h5>');
            }
            $confirmation_modal.modal('show');


            $confirmation_modal.find('#confirm_button').off('click').on('click', async function (event){
                let index;
                if (item_type === 'topic'){
                    await sendAjaxRequest('/api/remove-topic', itemID);

                    $tr.remove();
                    index = selected_book.topics.findIndex(topic => topic.id === itemID);
                    selected_book.topics.splice(index, 1);
                } else if (item_type === 'section'){
                    await sendAjaxRequest('/api/remove-section', itemID);

                    $tr.remove();
                    index = selected_topic.sections.findIndex(section => section.id === itemID);
                    selected_topic.sections.splice(index, 1);
                } else if(item_type === 'word'){
                    await sendAjaxRequest('/api/remove-word', itemID);

                    $tr.remove();
                    index = selected_section.words.findIndex(word => word.id === itemID);
                    selected_section.words.splice(index, 1);
                }

                $confirmation_modal.modal('hide');
            });

        });
}

function handleBreadcrumbs(){
    breadcrumbs.on('click', 'a', function (event){
        event.preventDefault();
        const level = $(this).closest('li').attr('data-level');
        if (level === 'book'){
            renderTopics();
        } else if (level === 'topic'){
            renderSections();
        }
    });
}


// render functions
///////////////////////////////////////////////////////////////////////////////////////////
function renderBooks(){
    $book_items_container.empty();

    book_list.forEach(book => {
        const book_item = book_item_template_HTML
            .replace(/{bookID}/, book.id)
            .replace(/{bookTitle}/, book.title);

        $book_items_container.append(book_item);
    });
}

function renderTopics(){
    updateBreadcrumbs('book');
    $table.empty();

    //Table head construct
    const table_head = table_head_template.replace(/{item_name}/, 'Topic');

    $table.append(table_head);

    let $tbody = $table.find('tbody');

    selected_book.topics.forEach((topic, index) => {
        const topic_item = $(table_item_template_HTML
            .replace(/{index}/, index + 1)
            .replace(/{item.id}/, topic.id)
            .replace(/{item.name}/, topic.name));

        topic_item.attr('data-item-type', 'topic');

        $tbody.append(topic_item);
    });
}

function renderSections(){
    updateBreadcrumbs('topic');
    $table.empty();

    //Table head construct
    const table_head = table_head_template.replace(/{item_name}/, 'Sub-topic');
    $table.append(table_head);

    const $tbody = $table.find('tbody');

    selected_topic.sections.forEach((section,index) => {
        const section_item = $(table_item_template_HTML
            .replace(/{index}/, index + 1)
            .replace(/{item.id}/, section.id)
            .replace(/{item.name}/, section.name));

        section_item.attr('data-item-type', 'section');
        $tbody.append(section_item);
    });
}

function renderWords(){
    updateBreadcrumbs('section');
    $table.empty();

    //construct thead
    const table_head = $(table_head_template
        .replace(/{item_name}/, 'Word'));

    table_head.children().children().eq(-1).before($('<th>').text('Translate'));
    table_head.children().children().eq(-1).before($('<th>').text('Type'));
    table_head.children().children().eq(-1).before($('<th>').text('Article'));
    table_head.children().children().eq(-1).before($('<th>').text('Plural'));
    table_head.children().children().eq(-1).before($('<th>').text('3-rd person'));
    table_head.children().children().eq(-1).before($('<th>').text('Perfect'));
    table_head.children().children().eq(-1).before($('<th>').text('Help verb'));
    table_head.children().children().eq(-1).before($('<th>').text('Prataritum'));
    table_head.children().children().eq(-1).before($('<th>').text('Verb type'));
    table_head.children().children().eq(-1).before($('<th>').text('Prefix'));

    $table.append(table_head);

    const $tbody = $table.find('tbody');

    selected_section.words.forEach((word,index) => {
        // construct table_item
        const word_item = $(table_item_template_HTML
            .replace(/{index}/, index + 1)
            .replace(/{item.id}/, word.id)
            .replace(/{item.name}/,word.word));

        word_item.children().eq(-1).before($('<td>').text(word.wordTranslate));
        word_item.children().eq(-1).before($('<td>').text(word.type));
        word_item.children().eq(-1).before($('<td>').text(word.article || ''));
        word_item.children().eq(-1).before($('<td>').text(word.pluralForm || ''));
        word_item.children().eq(-1).before($('<td>').text(word.thirdPersonForm || ''));
        word_item.children().eq(-1).before($('<td>').text(word.perfectForm || ''));
        word_item.children().eq(-1).before($('<td>').text(word.hilfVerbVergangenheit || ''));
        word_item.children().eq(-1).before($('<td>').text(word.prataritumForm || ''));
        word_item.children().eq(-1).before($('<td>').text(word.verbType || ''));
        word_item.children().eq(-1).before($('<td>').text(word.prefix || ''));

        word_item.attr('data-item-type', 'word');
        $tbody.append(word_item);
    });
}

// create input for edit item
function createInputWithHandlers(url, itemID, item_title, successCallback){
    return $('<input>', {
        type: 'text',
        value: item_title,
        class: 'form-control',
        click: function (e){e.stopPropagation()},
        keydown: async function (e) { // save newBookTitle
            if (e.key === 'Enter' && $(this).val().length > 0) {
                let response = await sendAjaxRequest(url + itemID, $(this).val(),
                    function (){alert('Item already exist')});
                successCallback(response);
            }
        }
    });
}

function createInputTemplate(url, itemID, successCallback){
    return $('<input>', {
        type: 'text',
        value: '',
        class: 'form-control',
        click: function (e){e.stopPropagation()},
        keydown: async function (e) { // save newBookTitle
            if (e.key === 'Enter' && $(this).val().length > 0) {
                let response = await sendAjaxRequestJSON(url,{itemID:itemID , itemTitle : $(this).val()},
                    function (){alert('Item already exist')});
                successCallback(response);
            }
        }
    });
}

function createInputEmptyTemplate(){
    return $('<input>', {
        type: 'text',
        value: '',
        class: 'form-control',
        click: function (e){e.stopPropagation()}
    });
}

function updateBreadcrumbs(item_type){
    breadcrumbs.empty();

    let breadcrumbHTML = '';

    if (item_type === 'book') {
        breadcrumbHTML += `<li class="breadcrumb-item active" data-level="book" aria-current="page">${selected_book.title}</li>`;
    } else if (item_type === 'topic') {
        breadcrumbHTML += `<li class="breadcrumb-item" data-level="book" ><a href="#" class="breadcrumb-link" >${selected_book.title}</a></li>`;
        breadcrumbHTML += `<li class="breadcrumb-item active" data-level="topic" aria-current="page">${selected_topic.name}</li>`;
    } else if (item_type === 'section') {
        breadcrumbHTML += `<li class="breadcrumb-item" data-level="book"><a href="#" class="breadcrumb-link" >${selected_book.title}</a></li>`;
        breadcrumbHTML += `<li class="breadcrumb-item" data-level="topic"><a href="#" class="breadcrumb-link" >${selected_topic.name}</a></li>`;
        breadcrumbHTML += `<li class="breadcrumb-item active" aria-current="page" data-level="section">${selected_section.name}</li>`;
    }

    breadcrumbs.append(breadcrumbHTML);
}

// send ajax
function sendAjaxRequest(url, data = {}, errorCallback) {
    return $.ajax({
        url: url,
        type: 'POST',
        data: data,
        contentType: 'text/plain; charset=UTF-8',
        headers: { [csrfHeader]: csrfToken },
        error: function(xhr, status, error) {
            if (errorCallback) {
                errorCallback(xhr, status, error);
            } else {
                console.error('Request failed:', status, error);
            }
        }
    });
}

// send ajax
function sendAjaxRequestJSON(url, data = {}, errorCallback) {
    return $.ajax({
        url: url,
        type: 'POST',
        data: JSON.stringify(data),
        contentType: 'application/json',
        headers: { [csrfHeader]: csrfToken },
        error: function(xhr, status, error) {
            if (errorCallback) {
                errorCallback(xhr, status, error);
            } else {
                console.error('Request failed:', status, error);
            }
        }
    });
}