import TopicPostBadges from "discourse/components/topic-post-badges";
import { apiInitializer } from "discourse/lib/api";
import { number } from "discourse/lib/formatter";
import DUserLink from "discourse/ui-kit/d-user-link";
import dAvatar from "discourse/ui-kit/helpers/d-avatar";
import dFormatDate from "discourse/ui-kit/helpers/d-format-date";
import dIcon from "discourse/ui-kit/helpers/d-icon";
import { i18n } from "discourse-i18n";


export default apiInitializer((api) => {
  api.renderInOutlet(
    "topic-list-item-mobile-avatar",
    <template>
      <DUserLink
        @ariaLabel={{i18n
          "latest_poster_link"
          username=@topic.creator.username
        }}
        @username={{@topic.creator.username}}
      >
        {{dAvatar @topic.creator imageSize="large"}}
      </DUserLink>
    </template>
  );

  api.renderInOutlet(
    "topic-list-after-title",
    <template>
      <span class="mdtlm">
        <TopicPostBadges
          @unreadPosts={{@outletArgs.topic.unread_posts}}
          @url={{@outletArgs.topic.lastUnreadUrl}}
        />
      </span>
    </template>
  );

  api.renderInOutlet(
    "topic-list-after-category",
    <template>
      <span class="mdtlm comments">
        {{dIcon "far-comment"}}
        <a href="{{@outletArgs.topic.firstPostUrl}}">{{number
            @outletArgs.topic.replyCount
            noTitle="true"
          }}</a>
      </span>
      <span class="mdtlm latest-poster-and-time__container">
        <span class="latest-poster-and-time">
          {{#if @topic.replyCount}}
            <a
              href={{@topic.lastPostUrl}}
              aria-label={{i18n
                "latest_poster_link"
                username=@topic.lastPosterUser.username
              }}
              data-user-card={{@topic.lastPosterUser.username}}
            >{{dAvatar @topic.lastPosterUser imageSize="small"}}</a>
          {{/if}}
          <span title={{@topic.bumpedAtTitle}} class="age activity">
            <a href={{@topic.lastPostUrl}}>{{dFormatDate
                @topic.bumpedAt
                format="tiny"
                noTitle="true"
              }}</a>
          </span>
        </span>
      </span>
    </template>
  );

  api.renderInOutlet(
    "topic-list-main-link-bottom",
    <template>
      <div class="mdtlm category-author-comments">
		<span class="topic-creator">
			{{dIcon "user"}} <a href="/users/{{@topic.creator.username}}" data-auto-route="true" data-user-card="{{@topic.creator.username}}">{{@topic.creator.username}}</a>
		</span>
		<span class="comments-cat">
			{{dIcon "far-comment"}} <a href="{{@topic.firstPostUrl}}">{{number @topic.posts_count}}</a>
		</span>
	</div>
    </template>
  );

});
