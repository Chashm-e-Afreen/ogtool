<script>
	import { selectPersonas, addPersona, onPersonaNameChange, onPersonaToneChange } from '@output/ContentCalendar';
</script>

<section class="group relative overflow-hidden rounded-2xl border border-slate-200 bg-white/50 p-6 shadow-sm backdrop-blur-sm transition-all hover:shadow-md dark:border-slate-800 dark:bg-slate-900/50">
    <div class="absolute top-0 right-0 p-4 opacity-5 transition-opacity group-hover:opacity-10">
        <svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" viewBox="0 0 24 24" fill="currentColor" class="text-pink-500"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
    </div>

	<div class="mb-6 flex items-center justify-between">
		<h2 class="flex items-center gap-2 text-lg font-semibold tracking-tight">
			<span class="flex h-8 w-8 items-center justify-center rounded-lg bg-pink-100 text-pink-600 dark:bg-pink-900/30 dark:text-pink-400">
                <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
            </span>
			Personas
		</h2>
		<button 
            on:click={addPersona} 
            class="flex items-center gap-1.5 rounded-lg bg-pink-50 px-3 py-1.5 text-xs font-bold text-pink-600 transition-colors hover:bg-pink-100 dark:bg-pink-900/20 dark:text-pink-400 dark:hover:bg-pink-900/40"
        >
			<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
			Add
		</button>
	</div>

	<div class="space-y-4">
		{#each $selectPersonas as persona, i}
			<div class="flex gap-3 rounded-xl bg-white p-2 shadow-sm ring-1 ring-slate-100 transition-all focus-within:ring-2 focus-within:ring-pink-500/20 dark:bg-slate-800 dark:ring-slate-700">
                <div class="flex-1 space-y-1">
                    <label class="px-2 text-[10px] font-bold text-slate-400 uppercase tracking-wider">Name</label>
                    <input
                        type="text"
                        placeholder="e.g. Founder Frank"
                        value={persona.name}
                        on:input={onPersonaNameChange(i)}
                        class="w-full bg-transparent px-2 pb-1 text-sm font-medium text-slate-700 placeholder:text-slate-300 focus:outline-none dark:text-slate-200"
                    />
                </div>
                <div class="w-px bg-slate-100 dark:bg-slate-700"></div>
                <div class="flex-1 space-y-1">
                    <label class="px-2 text-[10px] font-bold text-slate-400 uppercase tracking-wider">Tone</label>
                    <input
                        type="text"
                        placeholder="e.g. Professional"
                        value={persona.tone}
                        on:input={onPersonaToneChange(i)}
                        class="w-full bg-transparent px-2 pb-1 text-sm font-medium text-slate-700 placeholder:text-slate-300 focus:outline-none dark:text-slate-200"
                    />
                </div>
			</div>
		{/each}
	</div>
</section>