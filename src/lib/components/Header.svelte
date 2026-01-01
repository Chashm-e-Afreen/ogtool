<script>
	import { selectActiveTab, setActiveTab } from '@output/ContentCalendar';
</script>

<header
	class="sticky top-0 z-10 border-b border-slate-200 bg-white/80 backdrop-blur-md dark:border-slate-800 dark:bg-slate-900/80"
>
	<div class="mx-auto flex max-w-7xl items-center justify-between px-4 py-4 sm:px-6 lg:px-8">
		<div class="flex items-center gap-3">
			<div
				class="flex h-10 w-10 items-center justify-center rounded-xl bg-indigo-600 font-bold text-white shadow-lg shadow-indigo-500/20"
			>
				OG
			</div>
			<h1 class="text-xl font-bold tracking-tight">Content Planner</h1>
		</div>

		<nav class="flex gap-1 rounded-lg bg-slate-100 p-1 dark:bg-slate-800">
			<button
				on:click={() => setActiveTab('calendar')()}
				class="cursor-pointer rounded-md px-4 py-1.5 text-sm font-medium transition-all {$selectActiveTab ===
				'calendar'
					? 'bg-white text-indigo-600 shadow-sm dark:bg-slate-700 dark:text-white'
					: 'text-slate-500 hover:text-slate-700 dark:text-slate-400 dark:hover:text-slate-200'}"
			>
				Calendar
			</button>
			<button
				on:click={() => setActiveTab('settings')()}
				class="cursor-pointer rounded-md px-4 py-1.5 text-sm font-medium transition-all {$selectActiveTab ===
				'settings'
					? 'bg-white text-indigo-600 shadow-sm dark:bg-slate-700 dark:text-white'
					: 'text-slate-500 hover:text-slate-700 dark:text-slate-400 dark:hover:text-slate-200'}"
			>
				Strategy / Inputs
			</button>
		</nav>
	</div>
</header>
