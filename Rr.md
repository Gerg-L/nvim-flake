> Can you please show me the following results?
> 
> Open an AsciiDoc file in nvim and execute the following commands:
> 
>     * `lua print(vim.g.tigion_asciidocPreview_rootDir)` (this shows the plugin path)
> `/nix/store/8hnhmgimylvbfxlrvxalkn0qf4y82hqr-source`

>     * `lua print(vim.fn.stdpath('log'))` (this shows the log and cache path of nvim)
> 
>     * `lua print(vim.fn.stdpath('cache'))`
> 
> 
> Open the Preview with `:AsciidocPreview`, wait for the webbrowser and run the following command in the terminal:
> 
>     * `ps -ax | grep -v grep | grep nvim-asciidoc-preview` (this shows, if the preview server is running)
> 
> 
> Warning
> 
> Attention, the user name is displayed. So perhaps anonymize this information first.


/nix/store/8hnhmgimylvbfxlrvxalkn0qf4y82hqr-source
/home/user/.local/state/gerg
/home/user/.cache/gerg
E492: Not an editor command: AsciidocPreview

