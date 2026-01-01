<script>
	import { onMount } from 'svelte';
	// UI Components
	import Header from '$lib/components/Header.svelte';
	import CalendarView from '$lib/components/CalendarView.svelte';
	import CompanyForm from '$lib/components/CompanyForm.svelte';
	import PersonasForm from '$lib/components/PersonasForm.svelte';
	import SubredditsForm from '$lib/components/SubredditsForm.svelte';
	import TopicsForm from '$lib/components/TopicsForm.svelte';

	// Logic from PureScript (Co-located in same directory)
	import { 
		selectCalendar,
        selectActiveTab,
		generate,
		nextWeek,
        setActiveTab
	} from '@output/ContentCalendar';

	// Svelte Stores (from PureScript)
	let calendar = selectCalendar;
    let activeTab = selectActiveTab;

	const postsPerWeek = 5;

	onMount(() => {
		generate();
	});
</script>

<div class="min-h-screen bg-slate-50 text-slate-900 selection:bg-indigo-500 selection:text-white dark:bg-slate-950 dark:text-slate-100 transition-colors duration-500">
	<!-- Background Elements -->
	<div class="fixed inset-0 z-0 pointer-events-none">
		<div class="absolute top-[-10%] left-[-10%] h-[500px] w-[500px] rounded-full bg-indigo-400/20 blur-[100px] dark:bg-indigo-900/10"></div>
		<div class="absolute bottom-[-10%] right-[-10%] h-[500px] w-[500px] rounded-full bg-purple-400/20 blur-[100px] dark:bg-purple-900/10"></div>
	</div>

	<div class="relative z-10">
		<Header 
			activeTab={$activeTab} 
			onTabChange={setActiveTab} 
		/>

        <main class="mx-auto max-w-7xl p-4 sm:p-6 lg:p-8">
            {#if $activeTab === 'settings'}
                <div class="grid gap-8 lg:grid-cols-2">
                    <CompanyForm />
                    <PersonasForm />
                    <SubredditsForm />
                    <TopicsForm />
                </div>

                <div class="mt-8 flex justify-center">
                    <button
                        on:click={() => {
                            generate();
                            setActiveTab('calendar');
                        }}
                        class="cursor-pointer rounded-full bg-indigo-600 px-8 py-3 font-bold text-white shadow-xl shadow-indigo-500/40 transition-all hover:-translate-y-0.5 hover:bg-indigo-700 active:translate-y-0"
                    >
                        Save & Generate Strategy
                    </button>
                </div>
            {:else}
                <CalendarView 
                    calendar={$calendar} 
                    {postsPerWeek}
                    onNextWeek={nextWeek}
                />
            {/if}
        </main>
	</div>
</div>

<style>
	:global(body) {
		@apply transition-colors duration-300;
	}
</style>