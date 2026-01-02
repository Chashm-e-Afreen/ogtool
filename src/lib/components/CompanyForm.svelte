<script>
	import { selectCompany, onCompanyNameChange, onCompanyDescChange } from '@output/ContentCalendar';
</script>

<section
	class="group relative overflow-hidden rounded-2xl border border-slate-200 bg-white/50 p-6 shadow-sm backdrop-blur-sm transition-all hover:shadow-md dark:border-slate-800 dark:bg-slate-900/50"
>
	<div class="absolute top-0 right-0 p-4 opacity-5 transition-opacity group-hover:opacity-10">
		<svg
			xmlns="http://www.w3.org/2000/svg"
			width="64"
			height="64"
			viewBox="0 0 24 24"
			fill="currentColor"
			class="text-indigo-500"
			><rect x="2" y="3" width="20" height="14" rx="2" ry="2" /><line
				x1="8"
				y1="21"
				x2="16"
				y2="21"
			/><line x1="12" y1="17" x2="12" y2="21" /></svg
		>
	</div>

	<h2 class="mb-6 flex items-center gap-2 text-lg font-semibold tracking-tight">
		<span
			class="flex h-8 w-8 items-center justify-center rounded-lg bg-indigo-100 text-indigo-600 dark:bg-indigo-900/30 dark:text-indigo-400"
		>
			<svg
				xmlns="http://www.w3.org/2000/svg"
				width="18"
				height="18"
				viewBox="0 0 24 24"
				fill="none"
				stroke="currentColor"
				stroke-width="2"
				stroke-linecap="round"
				stroke-linejoin="round"
				><rect x="2" y="3" width="20" height="14" rx="2" ry="2" /><line
					x1="8"
					y1="21"
					x2="16"
					y2="21"
				/><line x1="12" y1="17" x2="12" y2="21" /></svg
			>
		</span>
		Company Profile
	</h2>
	<div class="space-y-5">
		<div>
			<label
				class="mb-1.5 block text-xs font-bold tracking-wider text-slate-500 uppercase"
				for="company-name">Company Name</label
			>
			<input
				id="company-name"
				type="text"
				value={$selectCompany.name}
				on:input={onCompanyNameChange}
				class="w-full rounded-xl border border-slate-200 bg-white px-4 py-2.5 text-sm font-medium shadow-sm transition-all focus:border-indigo-500 focus:ring-2 focus:ring-indigo-500/20 dark:border-slate-700 dark:bg-slate-800 dark:focus:border-indigo-400"
				placeholder="e.g. Acme Corp"
			/>
		</div>
		<div>
			<label
				class="mb-1.5 block text-xs font-bold tracking-wider text-slate-500 uppercase"
				for="company-desc">Description</label
			>
			<textarea
				id="company-desc"
				value={$selectCompany.description}
				on:input={onCompanyDescChange}
				class="w-full rounded-xl border border-slate-200 bg-white px-4 py-2.5 text-sm font-medium shadow-sm transition-all focus:border-indigo-500 focus:ring-2 focus:ring-indigo-500/20 dark:border-slate-700 dark:bg-slate-800 dark:focus:border-indigo-400"
				placeholder="What does your company do?"
			></textarea>
		</div>
	</div>
</section>
