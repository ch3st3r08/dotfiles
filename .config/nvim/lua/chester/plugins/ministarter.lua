return {
  "echasnovski/mini.starter",
  config = function()
    local starter = require('mini.starter')
    starter.setup({
      evaluate_single = true,
      items = {
        starter.sections.builtin_actions(),
        starter.sections.sessions(5, true),
        starter.sections.recent_files(10, false),
        starter.sections.recent_files(10, true),
      },
      content_hooks = {
        starter.gen_hook.adding_bullet(),
        starter.gen_hook.indexing('all', { 'Builtin actions' }),
        starter.gen_hook.padding(3, 2),
      },
    })

  end
}
