import ReactOnRails from 'react-on-rails';

import RockPaperScissors from '../bundles/RockPaperScissors/components/RockPaperScissors';

// This is how react_on_rails can see the RockPaperScissors in the browser.
ReactOnRails.register({
  RockPaperScissors,
});
