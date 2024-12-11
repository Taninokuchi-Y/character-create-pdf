document.addEventListener('DOMContentLoaded', () => {
  // ダイスロールの計算関数
  const rollDice = (formula) => {
    const regex = /(\d+)d(\d+)([+-]\d+)?/;
    const match = formula.match(regex);

    if (match) {
      const numDice = parseInt(match[1], 10);
      const diceSides = parseInt(match[2], 10);
      const modifier = match[3] ? parseInt(match[3], 10) : 0;

      const result = Array.from({ length: numDice }).reduce(
        (acc) => acc + Math.floor(Math.random() * diceSides + 1),
        0
      );
      return result + modifier;
    }
    
    console.error('Invalid dice formula:', formula); // 無効な式に対するエラーログ
    return 0; // 無効な式の処理
  };

  // 個別のダイスロール機能
  document.querySelectorAll('.roll-dice').forEach((button) => {
    if (button) {
      button.addEventListener('click', () => {
        const targetId = button.dataset.target;
        const formula = button.dataset.formula;

        // 計算
        const diceResult = rollDice(formula);

        // 結果を入力フィールドに設定
        const targetInput = document.getElementById(targetId);
        if (targetInput) {
          targetInput.value = diceResult;
          targetInput.dispatchEvent(new Event('input'));
        }
      });
    }
  });

  // 一括ダイスロール機能
  const rollAllDiceButton = document.getElementById('roll-all-dice');
  if (rollAllDiceButton) {
    rollAllDiceButton.addEventListener('click', () => {
      document.querySelectorAll('.roll-dice').forEach((button) => {
        const targetId = button.dataset.target;
        const formula = button.dataset.formula;

        // 計算
        const diceResult = rollDice(formula);

        // 結果を入力フィールドに設定
        const targetInput = document.getElementById(targetId);
        if (targetInput) {
          targetInput.value = diceResult;
          targetInput.dispatchEvent(new Event('input'));
        }
      });
    });
  }

  // 使用可能ポイント計算関数
  const eduInput = document.getElementById('character-edu');
  const intInput = document.getElementById('character-int');
  const totalPointsElement = document.getElementById('total-points');
  const remainingPointsElement = document.getElementById('remaining-points');
  const skillContainer = document.getElementById('custom-skills'); // カスタム技能を追加するコンテナ

  const calculateTotalPoints = () => {
    // totalPointsElementが存在する場合のみ処理を行う
    if (!totalPointsElement) {
      return; // totalPointsElementがない場合は早期に終了
    }

    const edu = parseInt(eduInput?.value || 0, 10);
    const int = parseInt(intInput?.value || 0, 10);
    const totalPoints = edu * 20 + int * 10;
    totalPointsElement.textContent = totalPoints;
    updateRemainingPoints(totalPoints);
  };

  const updateRemainingPoints = (totalPoints) => {
    let usedPoints = 0;

    // 既存の技能ポイントを計算
    document.querySelectorAll('.skill-point-input').forEach(input => {
      const baseValue = parseInt(input.dataset.base || 0, 10);
      const currentValue = parseInt(input.value || baseValue, 10);
      usedPoints += currentValue - baseValue;
    });

    // カスタム技能のポイントを計算
    document.querySelectorAll('.custom-skill-value').forEach(input => {
      usedPoints += parseInt(input.value || 0, 10); // カスタム技能のポイントも加算
    });

    const remainingPoints = totalPoints - usedPoints;
    if (remainingPointsElement) {
      remainingPointsElement.textContent = remainingPoints;
    }

    // 0以下の場合に赤色を適用
    if (remainingPoints <= 0) {
      remainingPointsElement.classList.add('text-danger');
    } else {
      remainingPointsElement.classList.remove('text-danger');
    }
  };

  // EDUとINTの変更を監視
  if (eduInput && intInput) {
    eduInput.addEventListener('input', calculateTotalPoints);
    intInput.addEventListener('input', calculateTotalPoints);
  }

  // 技能ポイント入力の変更を監視
  document.querySelectorAll('.skill-point-input').forEach(input => {
    input.addEventListener('input', () => {
      const totalPoints = parseInt(totalPointsElement?.textContent || 0, 10);
      updateRemainingPoints(totalPoints);
    });
  });

  // カスタム技能の追加ボタン
  const addCustomSkillButton = document.getElementById('add-skill');
  if (addCustomSkillButton) {
    addCustomSkillButton.addEventListener('click', () => {
      const skillDiv = document.createElement('div');
      skillDiv.classList.add('custom-skill');
      skillDiv.innerHTML = `
        <input type="text" name="character[custom_skills][][name]" placeholder="技能名" class="custom-skill-name">
        <input type="number" name="character[custom_skills][][value]" class="custom-skill-value" value="0" min="0">
        <button type="button" class="remove-skill">削除</button>
      `;
      skillContainer.appendChild(skillDiv);

      // 削除ボタン
      skillDiv.querySelector('.remove-skill').addEventListener('click', () => {
        skillDiv.remove();
        const totalPoints = parseInt(totalPointsElement?.textContent || 0, 10);
        updateRemainingPoints(totalPoints); // 削除後に残りポイントを更新
      });

      // 新しい技能のポイント入力を監視
      skillDiv.querySelector('.custom-skill-value').addEventListener('input', () => {
        const totalPoints = parseInt(totalPointsElement?.textContent || 0, 10);
        updateRemainingPoints(totalPoints);
      });
    });
  }

  // 初期値で計算
  calculateTotalPoints();
});

