<script>
    import { selectLoading as loading } from '@output/ContentCalendar.Selectors';
    import { generate } from '@output/ContentCalendar.Actions';
</script>

<div
    class="flex flex-col items-center justify-center rounded-3xl border border-dashed border-gray-300 bg-white py-20 text-center"
>
    <div class="mb-4 flex h-16 w-16 items-center justify-center rounded-full bg-gray-50">
        <svg
            xmlns="http://www.w3.org/2000/svg"
            width="32"
            height="32"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            stroke-width="1.5"
            stroke-linecap="round"
            stroke-linejoin="round"
            class="text-gray-400"
            ><rect width="18" height="18" x="3" y="4" rx="2" ry="2" /><line
                x1="16"
                y1="2"
                x2="16"
                y2="6"
            /><line x1="8" y1="2" x2="8" y2="6" /><line x1="3" y1="10" x2="21" y2="10" /><path
                d="M8 14h.01"
            /><path d="M12 14h.01" /><path d="M16 14h.01" /><path d="M8 18h.01" /><path
                d="M12 18h.01"
            /><path d="M16 18h.01" /></svg
        >
    </div>
    <h3 class="text-lg font-bold text-gray-900">No calendar generated yet</h3>
    <p class="mb-8 max-w-xs text-sm text-gray-500">
        Adjust your parameters and click regenerate to build your content strategy.
    </p>
    <button
        on:click={() => generate()()}
        disabled={$loading}
        class="cursor-pointer rounded-full bg-indigo-600 px-8 py-3 font-bold text-white shadow-xl shadow-indigo-500/40 transition-all hover:-translate-y-0.5 hover:bg-indigo-700 active:translate-y-0 disabled:bg-gray-400 disabled:cursor-not-allowed"
    >
        {$loading ? 'Generating...' : 'Generate Content Now'}
    </button>
</div>
