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

// Mobile-only link redirects: on small screens, redirect certain internal links to contact.html
(function(){
  function isInternalAnchor(a){ if(!a) return false; var h=a.getAttribute('href'); if(!h) return false; return !/^(https?:)?\/\//i.test(h) && !h.startsWith('mailto:') && !h.startsWith('tel:'); }
  document.addEventListener('click', function(e){
    if(window.innerWidth>992) return;
    var a = e.target.closest('a'); if(!a) return;
    if(!isInternalAnchor(a)) return;
    var href = a.getAttribute('href'); if(!href) return;
    var targets = ['gallery.html','about.html','destinations.html'];
    for(var i=0;i<targets.length;i++){ if(href.indexOf(targets[i])!==-1){ e.preventDefault(); window.location.href='contact.html'; return; } }
  }, {passive:false});
})();