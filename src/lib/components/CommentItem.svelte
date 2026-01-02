<script>
    export let comment;
</script>

<div class="flex gap-4">
    <div class="group relative flex-shrink-0 cursor-help">
        <div
            class="flex h-9 w-9 items-center justify-center rounded-xl bg-emerald-100 text-xs font-black text-emerald-700"
        >
            {comment.cAuthor.pName
                .split(' ')
                .map((n) => n[0])
                .join('')}
        </div>
        <!-- Tooltip -->
        <div
            class="invisible absolute bottom-full left-0 z-50 mb-3 w-64 rounded-xl border border-gray-700 bg-gray-900 p-4 text-[11px] text-white shadow-2xl group-hover:visible"
        >
            <p
                class="mb-2 border-b border-gray-700 pb-2 text-[9px] font-bold tracking-widest text-indigo-400 uppercase"
            >
                Persona Identity Profile
            </p>
            <p class="leading-relaxed opacity-90">{comment.cAuthor.pInfo}</p>
        </div>
    </div>
    <div
        class="flex-1 rounded-2xl rounded-tl-none border border-gray-100/50 bg-gray-50/80 p-4"
    >
        <div class="mb-1.5 flex items-center justify-between">
            <h4 class="text-xs font-black text-gray-900">
                {comment.cAuthor.pName}
            </h4>
            <span
                class="text-[9px] font-bold tracking-widest text-gray-400 uppercase"
                >+{comment.cDelayMinutes}m delay</span
            >
        </div>
        <p class="text-[13px] leading-normal text-gray-600">
            {comment.cContent}
        </p>
    </div>
</div>

<style>
	.group:hover .invisible {
		visibility: visible;
		opacity: 1;
	}
</style>
