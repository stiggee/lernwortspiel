// DOM constants
const books = $('div.book_list ul');
const breadcrumbs = $('.breadcrumb');
const offcanvasElement = $('#offcanvasExample')[0]; // Получаем DOM-элемент
const offcanvas = new bootstrap.Offcanvas(offcanvasElement); // Инициализируем offcanvas
const offcanvas_title = $('#offcanvas_title');
const button_back = $('#button_back');
const main_title = $('#main_title');
const word_list = $('.word_list');
const counter_html = $('.counter');

let $flipCard = $('#flipCard');
let currentWordIndex = 0;
// variables
let book_list;
let selected_book;
let selected_topic;
let selected_section;

$(document).ready(async function (){
    book_list = await $.get('/api/get-all-books');
    console.log(book_list);
    renderBooks();
    initEventHandlers();
});


function animateTitleChange(newTitle) {
    offcanvas_title.fadeOut(100, function() {  // Плавно исчезает старый текст
        $(this).text(newTitle).fadeIn(100);    // Изменяет текст и плавно появляется
    });
}

// Использование в функциях:
function renderBooks() {
    books.empty();
    breadcrumbs.empty();
    animateTitleChange('Books');
    button_back.hide();

    book_list.forEach((book, index) => {
        const book_item_html = `
            <li id="${book.id}" class="list-group-item" data-level="book">${book.title}</li>
`;
        const $book_item = $(book_item_html);

        $book_item
            .css({ opacity: 0, marginLeft: '20px' })
            .appendTo(books)
            .delay(index * 100)
            .animate({ opacity: 1, marginLeft: '0px' }, 300);
    });
}

function renderTopics() {
    updateBreadcrumbs('book');
    books.empty();
    animateTitleChange('Thema');
    button_back.show();

    selected_book.topics.forEach((topic, index) => {
        const topic_item_html = `<li id="${topic.id}" class="list-group-item" data-level="topic">${topic.name}</li>`;
        const $topic_item = $(topic_item_html);

        $topic_item
            .css({ opacity: 0, marginLeft: '20px' })
            .appendTo(books)
            .delay(index * 100)
            .animate({ opacity: 1, marginLeft: '0px' }, 300);
    });
}

function renderSections() {
    updateBreadcrumbs('topic');
    books.empty();
    animateTitleChange('Unterthema');

    selected_topic.sections.forEach((section, index) => {
        const section_item_html = `<li id="${section.id}" class="list-group-item" data-level="section">${section.name}</li>`;
        const $section_item = $(section_item_html);

        $section_item
            .css({ opacity: 0, marginLeft: '20px' })
            .appendTo(books)
            .delay(index * 100)
            .animate({ opacity: 1, marginLeft: '0px' }, 300);
    });
}

function initWords(){
        currentWordIndex = 0;
        $flipCard.remove();
        $flipCard = createNewCard(selected_section.words[currentWordIndex]);
        // $flipCard.addClass('new-card');
        $flipCard.css('opacity', 1);

}

function showWordListAndCounter(){
    word_list.find('ul').empty();
    selected_section.words.forEach((word,index) =>{
        let word_item_html = `<li class="list-group-item" data-index="${index}">${word.word}</li>`;

        if (word.type === 'NOUN'){
            word_item_html = `<li class="list-group-item" data-index="${index}">${word.article} ${word.word}</li>`;
        }
        word_list.find('ul').append(word_item_html);
    });

    word_list.find('li').eq(currentWordIndex).addClass('active');
    word_list.slideDown(700);

    counter_html.find('#current_word_index_html').text(currentWordIndex+1);
    counter_html.find('#current_word_lengths_html').text(selected_section.words.length);
    counter_html.slideDown(700);
}

function mainTitleInit(){
    var screenWidth = $(window).width();
    if (screenWidth < 576){
        main_title.text(selected_section.name);
    }
    else {
        main_title.text(selected_book.title + ' / ' + selected_topic.name + ' / ' + selected_section.name);
    }
}

function initEventHandlers(){
    books.on('click', 'li', function (e) {
        e.stopPropagation();
        const level = $(this).data('level');

        if (level === 'book'){
            selected_book = book_list.find(book => book.id === this.id);
            renderTopics();
        } else if (level === 'topic'){
            selected_topic = selected_book.topics.find(topic => topic.id === this.id);
            renderSections();
        } else if(level === 'section'){
            selected_section = selected_topic.sections.find(section => section.id === this.id);
            offcanvas.hide();
            mainTitleInit();
            initWords();
            showWordListAndCounter();
        }

    });

    //word list item click
    word_list.on('click', 'li', function (e){
        e.stopPropagation();
        currentWordIndex = ($(this).data('index') - 1);
        word_list.find('.active').removeClass('active');
        $(this).addClass('active');
        $('#nextCard').click();
    });

    //Trigger offcanvas button click
    $('#show_books').on('click', function() {
        offcanvas.show(); // Открываем offcanvas
    });

    //Offcanvas title click
    $('#offcanvas_book_list_button').on('click', function (e){
        renderBooks();
    });

    button_back.on('click', function (e){
       const level = $(this).next('ol').find('.active').data('level');
        console.log(level);

        if (level === 'topic'){
           renderTopics();
       } else if (level === 'book'){
            renderBooks();
        }

    });

    // Breadcrumb link click
    breadcrumbs.on('click', 'a', function (e){
        e.stopPropagation();
        const level = $(this).closest('li').data('level');

        if (level === 'book'){
            renderTopics();
        }
    });

    $flipCard.on('click', function () {
        $(this).removeClass('new-card new-card-right');
        $(this).toggleClass('flip');
    });


    $('#nextCard').on('click', function() {
        if (selected_section === undefined) {
            alertMainTitle();
            return;
        }

        if (currentWordIndex < selected_section.words.length - 1) {
            currentWordIndex++;
        } else {
            currentWordIndex = 0;
        }

        $flipCard.removeClass('new-card-right new-card flip');
        $flipCard.addClass('swipe-left');

        counter_html.find('#current_word_index_html').fadeOut(300, function() {
            $(this).text((currentWordIndex + 1)).fadeIn(300);
        });

        var newCard;
        setTimeout(() => {
            newCard = createNewCard(selected_section.words[currentWordIndex]);

            $flipCard.remove();
            $flipCard = newCard;

            $flipCard.addClass('new-card');
            $flipCard.css('opacity', 1);

            word_list.find('.active').removeClass('active');
            word_list.find(`li[data-index="${currentWordIndex}"]`).addClass('active');
        }, 600);
    });

    $('#prevCard').on('click', function() {
        if (selected_section === undefined) {
            alertMainTitle();
            return;
        }
        if (currentWordIndex > 0) {
            currentWordIndex -= 1;
        } else {
            currentWordIndex = selected_section.words.length - 1;
        }
        $flipCard.removeClass('new-card new-card-right flip');
        $flipCard.addClass('swipe-right');

        counter_html.find('#current_word_index_html').fadeOut(300, function() {
            $(this).text((currentWordIndex + 1)).fadeIn(300);
        });

        var newCard;
        setTimeout(() => {
            newCard = createNewCard(selected_section.words[currentWordIndex]);

            $flipCard.remove();
            $flipCard = newCard;
            $flipCard.addClass('new-card-right');
            $flipCard.css('opacity', 1);

            word_list.find('.active').removeClass('active');
            word_list.find(`li[data-index="${currentWordIndex}"]`).addClass('active');
        }, 600);
    });

    let $search = $('#search');
    const $suggestionsList = $('#suggestions');

    $search.on('input', async function() {

        const query = $(this).val().toLowerCase();


        let suggestions;
        if (query.length > 0){
           await $.ajax({
                url: '/api/get-suggestions',
                type: 'GET',
                data: { query: query }, // Передаем данные как параметры URL
                success: function(response) {
                    suggestions = response;
                },
                error: function(xhr, status, error) {
                    console.error('Request failed:', status, error);
                }
            });
        }

        $suggestionsList.empty(); // Очищаем список

        if (query.length > 1 && suggestions.length > 0) {
            suggestions.forEach((suggestion,index) => {
                if (index > 8) return;

                let $li_item = $(`<li class="list-group-item">${suggestion.word}</li>`);
                $li_item.on('click', function (e) {
                    $flipCard.find('#word').text(suggestion.word);
                    $flipCard.find('#word_trs').text(suggestion.wordTranslate);
                    $suggestionsList.slideUp(300);
                });
                

                $suggestionsList.append($li_item);
            });
            $suggestionsList.slideDown(300);
        } else {
            $suggestionsList.hide();
        }
    });

    $search.on('focus', function (e) {
        if ($(this).val().length > 1){
            $suggestionsList.slideDown(300);
        }
    });
    $search.on('blur', function (e){
        $suggestionsList.slideUp(300);
    });
}

function alertMainTitle(){
    for (let i = 0; i < 2; i++) {
        setTimeout(function() {
            main_title.fadeOut(300, function() {
                $(this).fadeIn(300);
            });
        }, i * 600); // 400ms for each cycle (200ms fadeOut + 200ms fadeIn)
    }
}

function createNewCard(word) {
    var newCard = $flipCard.clone();
    newCard.removeClass('swipe-left swipe-right new-card new-card-right');

    if (word.type === 'NOUN') {
        newCard.find('#word').text(word.article + ' ' + word.word);
        newCard.find('#word_trs').text(word.wordTranslate);
    } else {
        newCard.find('#word').text(word.word);
        newCard.find('#word_trs').text(word.wordTranslate);
    }
    newCard.css('opacity', 0);
    newCard.on('click', function () {
        $(this).removeClass('new-card new-card-right');
        $(this).toggleClass('flip');
    });
    $('.content-container').append(newCard);
    return newCard;
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
