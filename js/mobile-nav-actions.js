// Mobile nav actions: open mobile menu and focus mobile search input when search button is tapped
(function(){
    function onSearchButton(e){
        var btn = e.target.closest('.mobile-search-button');
        if(!btn) return;
        var mobileMenu = document.querySelector('.nav-menu');
        var mobileSearchInput = document.querySelector('.mobile-search input');
        // Open mobile menu if closed
        if(mobileMenu && !mobileMenu.classList.contains('active')){
            mobileMenu.classList.add('active');
            document.body.style.overflow = 'hidden';
        }
        // focus search input if present
        if(mobileSearchInput){
            setTimeout(function(){ mobileSearchInput.focus(); }, 220);
        }
    }
    document.addEventListener('click', onSearchButton);
})();