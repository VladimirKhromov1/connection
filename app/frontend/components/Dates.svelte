<script lang="ts">
    import type {Date} from "../store/DateStore";

    export let dates: Date
</script>

{#each dates as date}
    <div class="border rounded-5 date">
        <section class="p-4 text-center">
            <img class="date-img" src={dates[0].creator.photo} alt="pic">
            <h3 class="date-text">Date with this person</h3>
        </section>
        <div class="p-4 text-center border-top mobile-hidden">
            <a class="btn btn-success btn-lg accept">Accept</a>
            <a class="btn btn-danger btn-lg">Decline</a>
        </div>
    </div>
{/each}

<style>
    .accept {
        margin-right: 5rem;
        margin-left: 4rem;
    }
    .date {
        margin-right: 20%;
        margin-left: 20%;
        margin-bottom: 5rem;
    }
    .date-text {
        font-family: "Arial Black";
    }
    img {
        border-radius: 50%;
        float: left;
        width: 60px;
        height: 60px;
    }
    .date-img {
        margin-top: -0.6rem;
    }
</style>