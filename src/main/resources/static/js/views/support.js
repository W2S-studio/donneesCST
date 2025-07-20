document.addEventListener('DOMContentLoaded', () => {
    const form = document.getElementById('supportForm');
    const nameFld = document.getElementById('supportName');
    const emailFld = document.getElementById('supportEmail');
    const subjFld = document.getElementById('supportSubject');
    const msgFld = document.getElementById('supportMessage');

    const fields = [nameFld, emailFld, subjFld, msgFld];
    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    function validateField(field) {
        let ok = field.value.trim() !== '';
        if (field === emailFld) {
            ok = emailPattern.test(field.value.trim());
        }
        field.classList.toggle('is-valid', ok);
        field.classList.toggle('is-invalid', !ok);
        return ok;
    }

    fields.forEach(field => {
        field.addEventListener('input', () => validateField(field));
    });

    form.addEventListener('submit', e => {
        const allValid = fields.map(validateField).every(v => v);
        if (!allValid) {
            e.preventDefault();
            const firstInvalid = fields.find(f => f.classList.contains('is-invalid'));
            if (firstInvalid) firstInvalid.focus();
        }
    });

    const globalSearch = document.getElementById('globalSearch');
    const primaryFAQ = document.getElementById('primaryFAQ');
    const accordionContainer = document.getElementById('additionalQuestionsAccordion');
    const noResults = document.getElementById('noResults');

    // Get section headers
    const sectionTitle = document.querySelector('.section-title');
    const additionalTitle = document.querySelector('.additional-title');

    globalSearch.addEventListener('input', function () {
        const searchTerm = this.value.toLowerCase().trim();

        if (searchTerm === '') {
            showAllItems();
            noResults.classList.add('d-none');
            // Show section headers when no search is active
            if (sectionTitle) sectionTitle.classList.remove('d-none');
            if (additionalTitle) additionalTitle.classList.remove('d-none');
            return;
        }

        let hasResults = false;
        let hasPrimaryResults = false;
        let hasAdditionalResults = false;

        const primaryCards = primaryFAQ.querySelectorAll('.faq-card-open');
        primaryCards.forEach(card => {
            const keywords = card.getAttribute('data-keywords').toLowerCase();
            const question = card.querySelector('.faq-question-open').textContent.toLowerCase();
            const answer = card.querySelector('.faq-answer-open').textContent.toLowerCase();

            if (keywords.includes(searchTerm) ||
                question.includes(searchTerm) ||
                answer.includes(searchTerm)) {
                card.classList.remove('d-none');
                hasResults = true;
                hasPrimaryResults = true;
            } else {
                card.classList.add('d-none');
            }
        });

        const accordionItems = accordionContainer.querySelectorAll('.accordion-item');
        accordionItems.forEach(item => {
            const keywords = item.getAttribute('data-keywords').toLowerCase();
            const question = item.querySelector('.accordion-button').textContent.toLowerCase();
            const answer = item.querySelector('.accordion-body').textContent.toLowerCase();

            if (keywords.includes(searchTerm) ||
                question.includes(searchTerm) ||
                answer.includes(searchTerm)) {
                item.classList.remove('d-none');
                hasResults = true;
                hasAdditionalResults = true;
            } else {
                item.classList.add('d-none');
                const collapse = item.querySelector('.accordion-collapse');
                if (collapse && collapse.classList.contains('show')) {
                    const bsCollapse = new bootstrap.Collapse(collapse, { toggle: false });
                    bsCollapse.hide();
                }
            }
        });

        if (sectionTitle) {
            sectionTitle.classList.toggle('d-none', !hasPrimaryResults);
        }
        if (additionalTitle) {
            additionalTitle.classList.toggle('d-none', !hasAdditionalResults);
        }

        noResults.classList.toggle('d-none', hasResults);

        const visibleAccordionItems = accordionContainer.querySelectorAll('.accordion-item:not(.d-none)');
        accordionContainer.classList.toggle('d-none', visibleAccordionItems.length === 0);
    });

    function showAllItems() {
        const primaryCards = primaryFAQ.querySelectorAll('.faq-card-open');
        primaryCards.forEach(card => {
            card.classList.remove('d-none');
        });

        const accordionItems = accordionContainer.querySelectorAll('.accordion-item');
        accordionItems.forEach(item => {
            item.classList.remove('d-none');
        });

        accordionContainer.classList.remove('d-none');
    }

    const faqCards = document.querySelectorAll('.faq-card-open');
    faqCards.forEach((card, index) => {
        card.style.animationDelay = `${index * 0.1}s`;
        card.classList.add('animate-fade-in');
    });

    const accordionItems = document.querySelectorAll('.accordion-item');
    accordionItems.forEach((item, index) => {
        item.style.animationDelay = `${index * 0.05}s`;
        item.classList.add('animate-fade-in');
    });

    accordionItems.forEach(item => {
        const button = item.querySelector('.accordion-button');
        button.addEventListener('click', function () {
            console.log('Accordion question clicked:', this.textContent.trim());
        });
    });
});