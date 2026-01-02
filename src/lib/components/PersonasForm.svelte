<script>
	import { selectPersonas, selectSelectedPersonas, togglePersona } from '@output/ContentCalendar';
</script>

<section class="group relative overflow-hidden rounded-2xl border border-slate-200 bg-white/50 p-6 shadow-sm backdrop-blur-sm transition-all hover:shadow-md dark:border-slate-800 dark:bg-slate-900/50">
	<div class="mb-6 flex items-center justify-between">
		<h2 class="flex items-center gap-2 text-lg font-semibold tracking-tight text-slate-900 dark:text-white">
			<span class="flex h-8 w-8 items-center justify-center rounded-lg bg-pink-100 text-pink-600 dark:bg-pink-900/30 dark:text-pink-400">
                <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
            </span>
			Active Personas
		</h2>
        <span class="text-xs font-medium text-slate-400">{$selectSelectedPersonas.length} selected</span>
	</div>

	<div class="space-y-4">
		{#each $selectPersonas as persona}
            {@const isSelected = $selectSelectedPersonas.includes(persona.pName)}
			<button
                on:click={() => togglePersona(persona.pName)()}
                class="w-full text-left rounded-xl p-4 shadow-sm ring-1 transition-all {isSelected 
                    ? 'bg-white ring-pink-500 shadow-md dark:bg-slate-800 dark:ring-pink-600' 
                    : 'bg-white/50 ring-slate-100 opacity-60 grayscale hover:opacity-100 hover:grayscale-0 dark:bg-slate-900/30 dark:ring-slate-800'}"
            >
                <div class="flex items-center justify-between">
                    <div class="text-sm font-bold {isSelected ? 'text-slate-900 dark:text-slate-100' : 'text-slate-500 dark:text-slate-400'}">
                        {persona.pName}
                    </div>
                    {#if isSelected}
                        <div class="h-4 w-4 rounded-full bg-pink-500 flex items-center justify-center text-[10px] text-white">
                            ✓
                        </div>
                    {/if}
                </div>
                <div class="mt-1 text-xs leading-relaxed {isSelected ? 'text-slate-500 dark:text-slate-400' : 'text-slate-400 dark:text-slate-500'}">
                    {persona.pInfo}
                </div>
			</button>
		{/each}
	</div>
</section>
