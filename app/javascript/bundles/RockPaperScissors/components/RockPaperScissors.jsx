import React, { useCallback, useState } from "react"
import PropTypes from "prop-types"
import ReactModal from 'react-modal'
import ReactOnRails from 'react-on-rails'
import cx from 'classnames'

import * as styles from './RockPaperScissors.module.css'

import Rock from './Rock.svg'
import Paper from './Paper.svg'
import Scissors from './Scissors.svg'
import Loading from './loader.svg'
import Logo from './curb_logo@2x.png'

const CurbLogo = () => {
  return (
    <img src={Logo} height={24} />
  )
}

const ChoiceImage = ({ className, value }) => {
  let image = null;
  let imageHeight = null;
  switch (value) {
    case 'rock':
      image = Rock
      imageHeight = 139
      break
    case 'paper':
      image = Paper
      imageHeight = 161
      break
    case 'scissors':
      image = Scissors
      imageHeight = 160
      break
    default:
      image = Loading
      imageHeight = 10
  }
  return <img className={className} src={image} height={imageHeight} />
}

const Choice = ({ label, onClick, value }) => {
  return (
    <div className={styles.choice} onClick={() => onClick?.(value)}>
      <ChoiceImage value={value} />
      <div className={styles.choiceLabel}>{label}</div>
    </div>
  )
}

const Results = ({ curb_choice: curbChoice, userChoice: user_choice, winner }) => {
  let curbVerb = null
  let userVerb = null
  switch (winner) {
    case 'tie':
      curbVerb = 'ties'
      userVerb = 'tied'
      break
    case 'user_won':
      curbVerb = 'loses'
      userVerb = 'won'
      break
    case 'curb_won':
      curbVerb = 'wins'
      userVerb = 'lost'
      break
  }
  return (
    <>
      <div className={cx(styles.modalHeader, styles.mb20)}>You {userVerb}!</div>
      <div className={cx(styles.description, styles.mb80)}>Curb with {curbChoice} {curbVerb}</div>
      <ChoiceImage className={styles.mb60} value={curbChoice} />
    </>
  )
}

const RockPaperScissors = () => {
  const [selected, setSelected] = useState(null)
  const [data, setData] = useState(null)
  const [isLoading, setIsLoading] = useState(false)

  const handleChoice = useCallback((choice) => {
    setSelected(choice)
    console.log(choice)

    // reads from DOM csrf token generated by Rails in <%= csrf_meta_tags %>
    const csrfToken = ReactOnRails.authenticityToken();
    const headers = ReactOnRails.authenticityHeaders({ 'Content-Type': 'application/json' });

    setIsLoading(true)
    fetch('http://localhost:3000/games.json', { method: "POST", headers, body: JSON.stringify({ choice }) })
      .then((response) => response.json())
      .then((json) => {
        setData(json)
        setIsLoading(false)
      })
      .catch((error) => console.error(error))
  }, [setSelected])

  const hideModal = useCallback(() => {
    setIsLoading(false)
    setData(null)
  })

  console.log('data', data)

  return (
    <React.Fragment>
      <div className={styles.container}>
        <div className={cx(styles.header, styles.mb40)}>ROCK – PAPER – SCISSORS</div>
        <div className={cx(styles.description, styles.mb40)}>
          Rock Paper Scissors is a zero sum game that is usually played by two people using their hands and no tools. The idea is to make shapes with an outstretched hand where each shape will have a certain degree of power and will lead to an outcome.
        </div>
        <div className={cx(styles.cta, styles.mb40)}>SELECT YOUR BET</div>
        <div className={styles.choiceContainer}>
          <Choice
            label="Rock"
            onClick={handleChoice}
            value="rock"
          />
          <Choice
            label="Paper"
            onClick={handleChoice}
            value="paper"
          />
          <Choice
            label="Scissors"
            onClick={handleChoice}
            value="scissors"
          />
        </div>
        <ReactModal
          style={{content: { left: 0, right: 0, marginLeft: 'auto', marginRight: 'auto', width: isLoading ? 880 : 500 }}}
          styles={styles.modal}
          isOpen={!!isLoading || !!data}
          onRequestClose={hideModal}
        >
          <div className={styles.modalContainer}>
            {!!isLoading && (
              <>
                <div className={cx(styles.modalHeader, styles.mb40)}>Waiting Curb’s choose</div>
                <div className={styles.choiceContainer}>
                  <Choice
                    label="Your bet"
                    value={selected}
                  />
                  <Choice
                    label={<CurbLogo />}
                  />
                </div>
              </>
            )}
            {!!data && !!data.winner && (
              <>
                <Results {...data} />
                <button onClick={hideModal}>OK</button>
              </>
            )}
          </div>
        </ReactModal>
      </div>
    </React.Fragment>
  )
}

export default RockPaperScissors
