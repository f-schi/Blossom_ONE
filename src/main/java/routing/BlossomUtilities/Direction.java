package routing.BlossomUtilities;

public class Direction {
    private Double directionValue;

    public Direction(Double direction) {
        this.directionValue = direction;
    }

    /**
     * Calculates the circular distance between this direction and the given one.
     * @param otherDirection the given direction
     * @return circular distance
     */
    public final double calculateDistanceBetweenThisDirectionAndOther(Direction otherDirection) {
        double distanceBetweenThisDirectionAndOther = Math.abs(this.directionValue - otherDirection.getDirectionValue());
        distanceBetweenThisDirectionAndOther = Math.min(distanceBetweenThisDirectionAndOther, 360 - distanceBetweenThisDirectionAndOther);

        return distanceBetweenThisDirectionAndOther;
    }

    /**
     * Sets the direction of current movement adjusted with the historic one.
     * public only for testing.
     * @param dx movement on the x-axis.
     * @param dy movement on the y-axis.
     * @param adjustmentParameter the influence the historic direction has.
     */
    public final void setDirectionFromMovement(double dx, double dy, double adjustmentParameter) {
        double adjustedHistoricDirection = (1 - adjustmentParameter) * this.directionValue;

        setDirectionValue(adjustedHistoricDirection + adjustmentParameter * calculateDirectionByMovement(dx, dy));
    }

    /**
     * Calculates the circular direction from a movement.
     * @param dx movement on the x-axis.
     * @param dy movement on the y-axis.
     * @return circular direction.
     */
    private double calculateDirectionByMovement(double dx, double dy) {
        double currentDirection = 0;

        if (dx != 0 || dy != 0) {
            currentDirection = Math.acos(dx / Math.sqrt(dx * dx + dy * dy));
            currentDirection = Math.toDegrees(currentDirection);

            //For 3. and 4. quadrant
            if (dy < 0) {
                currentDirection = 360 - currentDirection;
            }
        }
        return currentDirection;
    }

    public final Double getDirectionValue() {
        return directionValue;
    }

    public final void setDirectionValue(double directionValue) {
        this.directionValue = directionValue;
    }

    @Override
    public String toString() {
        return "Direction{" +
                "directionValue=" + directionValue +
                '}';
    }
}
