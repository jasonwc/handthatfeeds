!function ($) {

  "use strict"; // jshint ;_;
  
  var pluginName = 'portfilter';

 /* PUBLIC CLASS DEFINITION
  * ============================== */

  var PortFilter = function (element) {
    
    this.$element = $(element)
    this.stuff    = $('[data-tag]');
    this.target   = this.$element.data('target') || '';

  }

  PortFilter.prototype.filter = function (params) {
    var items = [],
      target = this.target;
    this.stuff
        .fadeOut('fast').promise().done(function(){
            $(this).each(function(){
                if($(this).data('tag') == target || target == 'all') 
                    items.push(this);
            });
            $(items).show()
        });  
  }


 /* PLUGIN DEFINITION
  * ======================== */

  var old = $.fn[pluginName]

  $.fn[pluginName] = function (option) {
    return this.each(function () {
      var $this = $(this)
        , data = $this.data(pluginName);
      
      if(!data) $this.data(pluginName, (data = new PortFilter(this)))
      
      if (option == 'filter') data.filter()
    })
  }
  
  // DEFAULTS
  $.fn[pluginName].defaults = {}
  
  // CONSTRUCTOR CONVENTION 
  $.fn[pluginName].Constructor = PortFilter;


 /* PORTFILTER NO CONFLICT
  * ================== */

  $.fn[pluginName].noConflict = function () {
    $.fn[pluginName] = old
    return this
  }

 /* PORTFILTER DATA-API
  * =============== */

  $(document).on('click.portfilter.data-api', '[data-toggle^=portfilter]', function (e) {
    $(this).portfilter('filter')
  })

}(window.jQuery);
