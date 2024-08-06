import React from "react"
import PropTypes from "prop-types"

import * as styles from './RockPaperScissors.module.css'

import Rock from './Rock.svg'
import Paper from './Paper.svg'
import Scissors from './Scissors.svg'

const RockPaperScissors = () => {
  return (
    <React.Fragment>
      <div className={styles.container}>
        <div className={styles.header}>ROCK – PAPER – SCISSORS</div>
        <div className={styles.description}>
          Rock Paper Scissors is a zero sum game that is usually played by two people using their hands and no tools. The idea is to make shapes with an outstretched hand where each shape will have a certain degree of power and will lead to an outcome.
        </div>
        <div className={styles.cta}>SELECT YOUR BET</div>
        <div className={styles.choiceContainer}>
          <div className={styles.choice}>
            <img src={Rock} height={139} />
            <div className={styles.choiceLabel}>Rock</div>
          </div>
          <div className={styles.choice}>
            <img src={Paper} height={161} />
            <div className={styles.choiceLabel}>Paper</div>
          </div>
          <div className={styles.choice}>
            <img src={Scissors} height={160} />
            <div className={styles.choiceLabel}>Scissors</div>
          </div>
        </div>
      </div>
    </React.Fragment>
  )
}

export default RockPaperScissors
