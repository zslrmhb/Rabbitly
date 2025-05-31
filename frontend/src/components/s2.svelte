<script lang="ts">
    export let instructions: string;


</script>

<div class="flex flex-col bg-base-100">
    <!-- Top Bar -->
    <div class="flex flex-row justify-between items-center p-3 bg-base-200 border-b border-base-300">
        <!-- Exit Button -->
        <button 
            class=""
            aria-label="Close Editor">
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
            </svg>
            Button
        </button>
        
        <!-- Progress Bar  -->
         <div class="">
            <progress class="">
                Progress
            </progress>
        </div>

        <!-- Dummy div for future content  -->
         <div class="w-8">
         </div>
    </div>

     <!-- Main Content -->
    <div class="flex flex-row gap-3 p-3">
        <!-- Instruction Panel  -->
        <div class="rounded-lg bg-base-200">
            Instructions
            {@html instructions}
        </div>

        <div class="flex flex-col">
            <!-- Code Editor  -->
            <div class="rounded-lg bg-base-200">
                Code Editor
                <textarea>
                </textarea>
            </div>

            <!-- Output Panel  -->
            <div class="rounded-lg bg-base-200">
                Output
            </div>
        </div>
    </div>
</div>