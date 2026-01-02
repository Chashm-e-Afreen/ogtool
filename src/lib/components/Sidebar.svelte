<script>
	import {
		selectPostsPerWeek as postsPerWeek,
		selectCurrentWeek as currentWeek,
		selectCompany as company,
		selectCompanies as companies,
		selectSelectedCompanyIndex as selectedCompanyIndex,
		selectSelectedSubreddits as selectedSubreddits,
		selectKeywordsString as keywordsString,
		selectLoading as loading,
		selectPersonas as personas,
		selectSelectedPersonas as selectedPersonas
	} from '@output/ContentCalendar.Selectors';

	import {
		generate,
		nextWeek,
		prevWeek,
		onPostsPerWeekChange,
		onKeywordsChange,
		toggleSubreddit,
		togglePersona,
		selectCompanyAction
	} from '@output/ContentCalendar.Actions';
</script>

<aside class="space-y-6 lg:col-span-4">
	<div class="rounded-2xl border border-gray-200 bg-white p-6 shadow-sm">
		<div class="mb-8 flex items-center justify-between">
			<h2 class="text-xs font-bold tracking-widest text-gray-400 uppercase">
				Campaign Orchestrator
			</h2>
			<span
				class="flex h-2 w-2 rounded-full {$loading ? 'animate-pulse bg-amber-500' : 'bg-green-500'}"
			></span>
		</div>

		<div class="space-y-6">
			<!-- Company Selection -->
			<div>
				<label class="mb-2 block text-[11px] font-bold tracking-tight text-gray-500 uppercase"
					>Active Project</label
				>
				<div class="grid grid-cols-1 gap-2">
					{#each $companies as comp, i}
						<button
							on:click={() => selectCompanyAction(i)()}
							class="flex cursor-pointer flex-col items-start rounded-xl border p-3 text-left transition-all {i ===
							$selectedCompanyIndex
								? 'border-indigo-600 bg-indigo-50 shadow-sm'
								: 'border-gray-100 bg-white hover:border-indigo-200'}"
						>
							<span
								class="text-sm font-bold {i === $selectedCompanyIndex
									? 'text-indigo-700'
									: 'text-gray-700'}">{comp.name}</span
							>
							<span class="line-clamp-1 text-[10px] text-gray-400">{comp.description}</span>
						</button>
					{/each}
				</div>
			</div>

			<!-- Week Selector -->
			<div>
				<label class="mb-2 block text-[11px] font-bold tracking-tight text-gray-500 uppercase"
					>Scheduling Window</label
				>
				<div class="flex items-center rounded-xl border border-gray-200 bg-gray-50 p-1">
					<button
						on:click={() => prevWeek()()}
						class="cursor-pointer rounded-lg p-2.5 text-gray-400 shadow-sm transition hover:bg-white hover:text-indigo-600 disabled:cursor-not-allowed disabled:opacity-30"
						disabled={$currentWeek <= 1}
					>
						<svg class="h-4 w-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"
							><path
								stroke-linecap="round"
								stroke-linejoin="round"
								stroke-width="2"
								d="M15 19l-7-7 7-7"
							></path></svg
						>
					</button>
					<div
						class="flex-1 text-center text-sm font-bold tracking-tighter text-gray-700 uppercase"
					>
						Week {$currentWeek}
					</div>
					<button
						on:click={() => nextWeek()()}
						class="cursor-pointer rounded-lg p-2.5 text-gray-400 shadow-sm transition hover:bg-white hover:text-indigo-600"
					>
						<svg class="h-4 w-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"
							><path
								stroke-linecap="round"
								stroke-linejoin="round"
								stroke-width="2"
								d="M9 5l7 7-7 7"
							></path></svg
						>
					</button>
				</div>
			</div>

			<!-- Posts Per Week Slider -->
			<div>
				<div class="mb-2 flex items-center justify-between">
					<label class="block text-[11px] font-bold tracking-tight text-gray-500 uppercase"
						>Volume (Posts/Week)</label
					>
					<span class="rounded bg-indigo-50 px-2 py-0.5 text-xs font-bold text-indigo-600"
						>{$postsPerWeek} Posts</span
					>
				</div>
				<input
					type="range"
					min="1"
					max="7"
					value={$postsPerWeek}
					on:input={(e) => onPostsPerWeekChange(e)()}
					class="h-2 w-full cursor-pointer appearance-none rounded-lg bg-gray-200 accent-indigo-600"
				/>
				<div
					class="mt-1 flex justify-between text-[9px] font-bold tracking-wider text-gray-400 uppercase"
				>
					<span>Low</span>
					<span>Max (7)</span>
				</div>
			</div>

			<!-- Personas Selection -->
			<div>
				<label class="mb-2 block text-[11px] font-bold tracking-tight text-gray-500 uppercase"
					>Personas ({$selectedPersonas.length})</label
				>
				<div class="flex flex-wrap gap-2">
					{#each $personas as p}
						{@const isSelected = $selectedPersonas.includes(p.pName)}
						<button
							on:click={() => togglePersona(p.pName)()}
							class="cursor-pointer rounded-lg border px-3 py-1.5 text-[10px] font-bold transition-all {isSelected
								? 'border-pink-500 bg-pink-500 text-white shadow-md'
								: 'border-gray-200 bg-white text-gray-500 hover:border-pink-200'}"
							title={p.pInfo}
						>
							{p.pName}
						</button>
					{/each}
				</div>
			</div>

			<!-- Subreddits -->
			<div>
				<label class="mb-2 block text-[11px] font-bold tracking-tight text-gray-500 uppercase"
					>Target Subreddits</label
				>
				<div class="flex flex-wrap gap-2">
					{#each $company.subreddits as sub}
						{@const isSelected = $selectedSubreddits.includes(sub)}
						<button
							on:click={() => toggleSubreddit(sub)()}
							class="cursor-pointer rounded-lg border px-3 py-1.5 text-xs transition-all {isSelected
								? 'border-indigo-600 bg-indigo-600 text-white shadow-md'
								: 'border-gray-200 bg-white text-gray-500 hover:border-indigo-300'}"
						>
							{sub}
						</button>
					{/each}
				</div>
			</div>

			<!-- Keywords -->
			<div>
				<label class="mb-2 block text-[11px] font-bold tracking-tight text-gray-500 uppercase"
					>Contextual Lenses</label
				>
				<textarea
					value={$keywordsString}
					on:input={(e) => onKeywordsChange(e)()}
					class="min-h-[100px] w-full rounded-xl border border-gray-200 p-3 text-sm shadow-sm transition-all outline-none focus:border-indigo-500 focus:ring-2 focus:ring-indigo-500/10 dark:bg-white"
					placeholder="e.g. pain points, specific product features..."
				></textarea>
			</div>

			<!-- Main Button -->
			<button
				on:click={() => generate()()}
				disabled={$loading}
				class="flex w-full transform cursor-pointer items-center justify-center gap-2 rounded-xl bg-gray-900 py-4 font-bold text-white shadow-xl transition-all hover:-translate-y-0.5 hover:bg-black hover:shadow-2xl disabled:transform-none disabled:cursor-not-allowed disabled:bg-gray-400"
			>
				<span>{$loading ? 'Generating...' : 'Regenerate Calendar'}</span>
			</button>
		</div>
	</div>
</aside>
